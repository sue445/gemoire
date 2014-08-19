# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  branch     :string(255)      default("master"), not null
#  ssh_url    :string(255)      not null
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
    Git.clone(self.ssh_url, self.id.to_s, path: Project.satellite_dir)
  end

  def self.satellite_dir
    # TODO
  end

  private
  def repository_dir
    File.join(Project.satellite_dir, self.id.to_s)
  end

end
