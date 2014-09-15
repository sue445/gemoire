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

  post :update_doc, with: :id, provides: [:json] do
    @project.update_doc_async

    { message: "Project was scheduled successfully" }.to_json
  end

  get :edit, with: :id do
    render :edit
  end

  put :update, with: :id do
    if @project.update_attributes(params[:project])
      flash[:success] = "Update success"
      redirect url(:projects, :index)
    else
      flash.now[:error] = "Update failed"
      render :edit
    end
  end

  get :show, with: :id do
    render :show
  end

  before :update_doc, :edit, :update, :show do
    @project = Project.find(params[:id])
  end
end
