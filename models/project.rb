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
#  index_projects_on_name  (name) UNIQUE
#

class Project < ActiveRecord::Base
  validates_presence_of :name, :branch, :remote_url
  validates_format_of :name  , with: /[a-zA-Z.0-9_\-]+/
  validates_format_of :branch, with: /[a-zA-Z.0-9_\-]+/

  after_save    :update_async
  after_destroy :remove_dirs

  def pull_remote
    if repository_dir.exist?
      git_fetch_and_reset
    else
      git_clone
    end
  end

  def git_clone
    Git.clone(self.remote_url, self.id.to_s, path: Config.satellite_root_dir)
  end

  def generate_doc
    Dir.chdir(repository_dir) do
      YARD::CLI::Yardoc.run(
        "--output-dir=#{doc_dir}",
        "--db=.yardoc",
        "--no-stats",
        "--quiet",
        "--yardopts=.yardopts"
      )
    end
  end

  def update_async
    # TODO sidekiq
    pull_remote
    generate_doc
  end

  private
  def git
    @git ||= Git.open(repository_dir, log: git_logger, repository: repository_dir.join(".git"))
  end

  def git_logger
    Logger.new(Padrino.root("log", "#{Padrino.env}.log"))
  end

  def doc_dir
    Config.doc_root_dir.join(self.name)
  end

  def repository_dir
    Config.satellite_root_dir.join(self.id.to_s)
  end

  def git_fetch_and_reset
    git.fetch
    git.reset_hard("origin/#{branch}")
  end

  def remove_dirs
    repository_dir.rmtree
    doc_dir.rmtree
  end
end
