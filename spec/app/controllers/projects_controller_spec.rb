RSpec.describe "ProjectsController" do
  describe "GET /" do
    before do
      create_list(:project, project_count)
    end

    subject!{ get "/" }

    let(:project_count){ 10 }

    it{ expect(assigns(:projects).count).to eq project_count }
    it{ expect(last_response).to be_ok }
  end

  describe "GET /projects/new" do
    subject!{ get "/projects/new" }

    it{ expect(last_response).to be_ok }
  end

  describe "POST /projects/create" do
    subject!{ post "/projects/create", params }

    context "When valid params" do
      let(:params){
        {
          project: attributes_for(:project)
        }
      }
      let(:project_name){ params[:project][:name] }

      it{ expect(last_response).to be_redirect }
      it{ expect(Project.where(name: project_name)).to be_exist }
    end

    context "When invalid params" do
      let(:params){ {} }

      it{ expect(last_response).not_to be_redirect }
    end
  end

  describe "POST /projects/update_doc/:id" do
    subject!{ post "/projects/update_doc/#{project.id}"}

    let(:project){ create(:project) }

    it{ expect(last_response).to be_redirect }
  end
end
