# Helper methods defined here can be accessed in any controller or view in the application

module Gemoire
  class App
    module ProjectsHelper
      def project_doc_path(project)
        "/doc/#{project.name}/#{project.branch}/index.html"
      end
    end

    helpers ProjectsHelper
  end
end
