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
    end

    helpers ProjectsHelper
  end
end
