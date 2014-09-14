RSpec.describe "WebhookController" do
  describe "POST /webhook" do
    let!(:project){ create(:project) }

    subject!{ post "/webhook", payload }

    let(:payload){ { remote_url: remote_url, branch: branch}.to_json }

    context "with valid params" do
      let(:remote_url){ project.remote_url }
      let(:branch)    { project.branch }

      it{ expect(last_response).to be_ok }
      it{ expect(last_response.body).to be_json }
      it{ expect(assigns(:projects).count).to eq 1 }
    end

    context "with invalid params" do
      let(:remote_url){ "git@github.com:dummy/invalid.git" }
      let(:branch)    { "master" }

      it{ expect(last_response).to be_not_found }
    end
  end
end
