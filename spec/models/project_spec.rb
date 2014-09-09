RSpec.describe Project do
  describe "#git_clone" do
    subject{ project.git_clone }

    let(:project)    { create(:project, name: "sample-repo", remote_url: remote_url) }
    let(:cloned_repo){ Pathname("#{temp_dir}/#{project.id}") }
    let(:cloned_file){ Pathname("#{cloned_repo}/README.md") }

    include_context "uses temp dir"

    shared_examples :a_git_clone_method do
      it "should clone from repository" do
        subject
        expect(cloned_file).to be_exist
      end
    end

    before do
      allow(Config).to receive(:satellite_root_dir){ temp_dir_path }
    end

    context "When ssh url", skip_on_ci: true do
      let(:remote_url){ "git@github.com:sue445/sample-repo.git" }
      it_behaves_like :a_git_clone_method
    end

    context "When https url" do
      let(:remote_url){ "https://github.com/sue445/sample-repo.git" }
      it_behaves_like :a_git_clone_method
    end

    context "When git url" do
      let(:remote_url){ "git://github.com/sue445/sample-repo.git" }
      it_behaves_like :a_git_clone_method
    end
  end

  describe "#pull_remote" do
    subject{ project.pull_remote }

    let(:project)   { create(:project, name: "sample-repo", remote_url: remote_url) }
    let(:remote_url){ "https://github.com/sue445/sample-repo.git" }

    include_context "uses temp dir"

    before do
      allow(Config).to receive(:satellite_root_dir){ temp_dir_path }
      project.git_clone
    end

    it "should be git fetch" do
      expect(project).to receive(:git_fetch_and_reset)
      subject
    end
  end

  describe "#generate_doc" do
    subject{ project.generate_doc }

    let(:project) { create(:project, name: "dummy") }
    let(:doc_dir) { Pathname("#{temp_dir}/#{project.name}") }
    let(:doc_file){ Pathname("#{doc_dir}/index.html") }

    include_context "uses temp dir"

    before do
      allow(project).to receive(:repository_dir){ dummy_dir }
      allow(Config).to receive(:doc_root_dir){ temp_dir_path }
    end

    it "should generate doc" do
      subject
      expect(doc_dir).to be_exist
      expect(doc_file).to be_exist
    end
  end
end
