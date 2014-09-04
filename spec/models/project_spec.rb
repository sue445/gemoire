RSpec.describe Project do
  describe "#git_clone" do
    subject{ project.git_clone }

    let(:project)    { create(:project, name: "rubicure", remote_url: remote_url) }
    let(:cloned_repo){ Pathname("#{temp_dir}/#{project.id}") }
    let(:cloned_file){ Pathname("#{cloned_repo}/README.md") }

    include_context "uses temp dir"

    before do
      allow(Global.gemoire).to receive(:satellite_root_dir){ temp_dir }
    end

    context "When ssh url", skip_on_ci: true do
      let(:remote_url){ "git@github.com:sue445/rubicure.git" }

      it "should clone from repository" do
        subject
        expect(cloned_repo).to be_exist
        expect(cloned_file).to be_exist
      end
    end

    context "When https url" do
      let(:remote_url){ "https://github.com/sue445/rubicure.git" }

      it "should clone from repository" do
        subject
        expect(cloned_repo).to be_exist
        expect(cloned_file).to be_exist
      end
    end
  end

  describe "#generate_doc" do
    subject{ project.generate_doc }

    let(:project) { create(:project, name: "dummy") }
    let(:doc_dir) { Pathname("#{temp_dir}/#{project.name}/#{project.branch}") }
    let(:doc_file){ Pathname("#{doc_dir}/index.html") }

    include_context "uses temp dir"

    before do
      allow(project).to receive(:repository_dir){ dummy_dir }
      allow(Global.gemoire).to receive(:doc_root_dir){ temp_dir }
    end

    it "should generate doc" do
      subject
      expect(doc_dir).to be_exist
      expect(doc_file).to be_exist
    end
  end
end
