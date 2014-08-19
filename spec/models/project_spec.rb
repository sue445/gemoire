RSpec.describe Project do
  describe "#git_clone", skip_on_ci: true do
    subject{ project.git_clone }

    let(:project)    { create(:project, name: "rubicure", ssh_url: "git@github.com:sue445/rubicure.git") }
    let(:cloned_repo){ Pathname("#{temp_dir}/#{project.id}") }
    let(:cloned_file){ Pathname("#{cloned_repo}/README.md") }

    include_context "uses temp dir"

    before do
      allow(Project).to receive(:satellite_dir).and_return(temp_dir)
    end

    it "should clone from repository" do
      subject
      expect(cloned_repo).to be_exist
      expect(cloned_file).to be_exist
    end
  end
end
