RSpec.describe "WebhookController" do
  shared_examples :a_webhook do
    context "when project is found" do
      let(:remote_url){ valid_remote_url }
      let(:branch)    { valid_branch }

      it{ expect(last_response).to be_ok }
      it{ expect(last_response.body).to be_json }
      it{ expect(assigns(:projects).count).to eq 1 }
    end

    context "when project is not found" do
      let(:remote_url){ "git@github.com:dummy/invalid.git" }
      let(:branch)    { "master" }

      it{ expect(last_response).to be_not_found }
    end

    context "with invalid json format" do
      let(:payload)   { "invalid json" }

      it{ expect(last_response).to be_bad_request }
    end
  end

  describe "POST /webhook" do
    let!(:project){ create(:project) }

    subject!{ post "/webhook", payload }

    let(:payload){ { remote_url: remote_url, branch: branch}.to_json }

    it_behaves_like :a_webhook do
      let(:valid_remote_url){ project.remote_url }
      let(:valid_branch)    { project.branch }
    end
  end

  describe "POST /webhook/github" do
    let!(:project){ create(:project, remote_url: remote_url, branch: branch) }

    subject!{ post "/webhook/github", payload }

    let(:remote_url){ "git@github.com:dummy/dummy.git" }
    let(:branch)    { "master" }
    let(:payload)   { fixture("payload/github.json") }

    it_behaves_like :a_webhook do
      let(:valid_remote_url){ "git@github.com:baxterthehacker/public-repo.git" }
      let(:valid_branch)    { "gh-pages" }
    end
  end
end
