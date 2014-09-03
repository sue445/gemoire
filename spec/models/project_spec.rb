RSpec.describe Project do
  describe "#git_clone", skip_on_ci: true do
    subject{ project.git_clone }

    let(:project)    { create(:project, name: "rubicure", ssh_url: "git@github.com:sue445/rubicure.git") }
    let(:cloned_repo){ Pathname("#{temp_dir}/#{project.id}") }
    let(:cloned_file){ Pathname("#{cloned_repo}/README.md") }

    include_context "uses temp dir"

    before do
      allow(Project).to receive(:satellite_dir){ temp_dir }
    end

    it "should clone from repository" do
      subject
      expect(cloned_repo).to be_exist
      expect(cloned_file).to be_exist
    end
  end

  describe "#generate_doc" do
    subject{ project.generate_doc }

    let(:project) { create(:project, name: "dummy") }
    let(:doc_dir) { Pathname("#{temp_dir}/#{project.name}") }
    let(:doc_file){ Pathname("#{doc_dir}/index.html") }

    include_context "uses temp dir"

    before do
      allow(project).to receive(:repository_dir){ dummy_dir.to_s }
      allow(project).to receive(:doc_dir){ doc_dir.to_s }
    end

    it "should generate doc" do
      subject
      expect(doc_dir).to be_exist
      expect(doc_file).to be_exist
    end
  end
end
