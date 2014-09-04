# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  branch     :string(255)      default("master"), not null
#  remote_url :string(255)      not null
#  commit     :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_projects_on_name_and_branch  (name,branch) UNIQUE
#

class Project < ActiveRecord::Base
  def git_clone
    Git.clone(self.remote_url, self.id.to_s, path: satellite_root_dir)
  end

  def generate_doc
    YARD::CLI::Yardoc.run(
      repository_dir.to_s,
      "--output-dir=#{doc_dir}",
      "--db=#{repository_dir}/.yardoc",
      "--no-stats",
      "--quiet"
    )
  end

  private
  def doc_dir
    doc_root_dir.join(self.name, self.branch)
  end

  def repository_dir
    satellite_root_dir.join(self.id.to_s)
  end

  def satellite_root_dir
    Pathname(Global.gemoire.satellite_root_dir)
  end

  def doc_root_dir
    Pathname(Global.gemoire.doc_root_dir)
  end
end
