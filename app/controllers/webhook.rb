Gemoire::App.controllers :webhook do
  disable :protect_from_csrf

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  post :index do
    update_projects(remote_url: @payload[:remote_url], branch: @payload[:branch])
  end

  # cf) https://developer.github.com/v3/activity/events/types/#pushevent
  post :github do
    remote_urls = [
      @payload[:repository][:git_url],
      @payload[:repository][:ssh_url],
      @payload[:repository][:clone_url],
    ]
    branch = @payload[:ref].gsub("refs/heads/", "")

    update_projects(remote_url: remote_urls, branch: branch)
  end

  # cf) https://confluence.atlassian.com/display/BITBUCKET/POST+hook+management
  post :bitbucket do
    repository_url = @payload[:canon_url] + @payload[:repository][:absolute_url].gsub(%r(/$), "")
    branches = @payload[:commits].map{|commit| commit[:branch] }
    update_projects(repository_url: repository_url, branch: branches)
  end

  # cf) https://github.com/gitlabhq/gitlabhq/blob/master/doc/web_hooks/web_hooks.md
  post :gitlab do

  end

  before except: [:bitbucket] do
    with_json_parser_error_handling do
      @payload = JSON.parse(request.body.read).with_indifferent_access
    end
  end

  before :bitbucket do
    with_json_parser_error_handling do
      request_body = request.body.read
      payload_string = CGI.unescape(request_body).gsub(/^payload=/, "")
      @payload = JSON.parse(payload_string).with_indifferent_access
    end
  end

  helpers do
    def update_projects(remote_url: nil, repository_url: nil, branch: nil)
      @projects = Project.all
      @projects.where!(remote_url: remote_url) if remote_url
      @projects.where!(repository_url: repository_url) if repository_url
      @projects.where!(branch: branch) if branch

      halt 404 if @projects.empty?

      @projects.map(&:update_doc_async)

      @projects.to_json
    end

    def with_json_parser_error_handling
      yield
    rescue JSON::ParserError
      # Bad Request
      halt 400
    end
  end

end
