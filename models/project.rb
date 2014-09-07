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
  validates_presence_of :name, :branch, :remote_url

  after_save :update_async

  def pull_remote
    if repository_dir.exist?
      git_fetch_and_reset
    else
      git_clone
    end
  end

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
  def git
    @git ||= Git.open(repository_dir, log: git_logger, repository: repository_dir.join(".git"))
  end

  def git_logger
    Logger.new(Padrino.root("log", "#{Padrino.env}.log"))
  end

  def doc_dir
    doc_root_dir.join(self.name, self.branch)
  end

  def repository_dir
    satellite_root_dir.join(self.id.to_s)
  end

  def satellite_root_dir
    absolute_path(Global.gemoire.satellite_root_dir)
  end

  def doc_root_dir
    absolute_path(Global.gemoire.doc_root_dir)
  end

  def git_fetch_and_reset
    git.fetch
    git.reset_hard("origin/#{branch}")
  end

  def update_async
    pull_remote
  end

  def absolute_path(path)
    dir = Pathname(path)
    dir = Pathname(Padrino.root(path)) if dir.relative?
    dir
  end
end
