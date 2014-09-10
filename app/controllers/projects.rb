Gemoire::App.controllers :projects do
  project_params = {project: [:name, :branch, :remote_url, :repository_url]}

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

  get :index, map: "/" do
    @projects = Project.order(:name)
    render :index
  end

  get :new do
    @project = Project.new
    render :new
  end

  post :create, params: [project_params] do
    @project = Project.new(params[:project])
    if @project.save
      flash[:success] = "Project was successfully created."
      redirect url(:projects, :index)
    else
      render :new
    end
  end

  post :update_async, map: "/projects/:id/update_async" do
    @project.update_async
    redirect url(:projects, :index)
  end

  before except: [:index, :new, :create] do
    @project = Project.find(params[:id])
  end

=begin
  post :create1 do
    puts params.to_json
    params.to_json
  end

  post :create2, params: [:girl] do
    puts params.to_json
    params.to_json
  end

  post :create3, params: [girl: [:human_name, :precure_name]] do
    puts params.to_json
    params.to_json
  end

  post :create4, params: {girl: [:human_name, :precure_name]} do
    puts params.to_json
    params.to_json
  end
=end
end
