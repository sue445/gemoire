# Helper methods defined here can be accessed in any controller or view in the application

module Gemoire
  class App
    module ApplicationHelper
      def glyphicon(name)
        content_tag(:span, "", class: "glyphicon glyphicon-#{name}")
      end
    end

    helpers ApplicationHelper
  end
end
