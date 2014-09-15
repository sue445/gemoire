RSpec.describe "WebhookController" do
  describe "POST /webhook" do
    let!(:project){ create(:project) }

    subject!{ post "/webhook", payload }

    let(:payload){ { remote_url: remote_url, branch: branch}.to_json }

    context "with valid payload" do
      let(:remote_url){ project.remote_url }
      let(:branch)    { project.branch }

      it{ expect(last_response).to be_ok }
      it{ expect(last_response.body).to be_json }
      it{ expect(assigns(:projects).count).to eq 1 }
    end

    context "with invalid payload" do
      let(:remote_url){ "git@github.com:dummy/invalid.git" }
      let(:branch)    { "master" }

      it{ expect(last_response).to be_not_found }
    end

    context "with invalid json format" do
      let(:payload){ "invalid json" }

      it{ expect(last_response).to be_bad_request }
    end
  end

  describe "POST /webhook/github" do
    let!(:project){
      create(
        :project,
        remote_url: "git@github.com:baxterthehacker/public-repo.git",
        branch: "gh-pages"
      )
    }

    subject!{ post "/webhook/github", payload }

    let(:payload){ fixture("payload/github.json") }

    context "with valid payload" do
      let(:remote_url){ project.remote_url }
      let(:branch)    { project.branch }

      it{ expect(last_response).to be_ok }
      it{ expect(last_response.body).to be_json }
      it{ expect(assigns(:projects).count).to eq 1 }
    end
  end
end
