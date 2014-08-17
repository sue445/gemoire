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

end
