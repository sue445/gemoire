# Helper methods defined here can be accessed in any controller or view in the application

module Gemoire
  class App
    module ProjectsHelper
      def project_doc_path(project)
        File.join(Global.gemoire.doc_path, project.name, "index.html")
      end

      def short_sha1(project)
        project.commit[0, 7] if project.commit.present?
      end

      def repository_icon(project)
        case project.repository_url
        when /github\.com/
          octicon("octoface")
        when /bitbucket\.org/
          fa("bitbucket")
        else
          octicon("repo")
        end
      end
    end

    helpers ProjectsHelper
  end
end
