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
    update_projects(@payload[:remote_url], @payload[:branch])
  end

  post :github do
    remote_urls = [
      @payload[:repository][:git_url],
      @payload[:repository][:ssh_url],
      @payload[:repository][:clone_url],
    ]
    branch = @payload[:ref].gsub("refs/heads/", "")

    update_projects(remote_urls, branch)
  end

  post :bitbucket do

  end

  post :gitlab do

  end

  before do
    begin
      @payload = JSON.parse(request.body.read).with_indifferent_access
    rescue JSON::ParserError
      # Bad Request
      halt 400
    end
  end

  helpers do
    def update_projects(remote_urls, branch)
      @projects = Project.where(remote_url: remote_urls, branch: branch)
      halt 404 if @projects.empty?

      @projects.map(&:update_doc_async)

      @projects.to_json
    end
  end

end
