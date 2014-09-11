# Helper methods defined here can be accessed in any controller or view in the application

module Gemoire
  class App
    module ApplicationHelper
      def glyphicon(name, title: "")
        content_tag(:span, title, class: "glyphicon glyphicon-#{name}")
      end

      def octicon(name, title: "", size: :normal)
        base_class =
          case size
          when :normal
            "octicon"
          when :mega
            "mega-octicon"
          when :more_mega
            "mega-octicon more-mega"
          when :really_more_mega
            "mega-octicon really-more-mega"
          else
            "octicon"
          end
        content_tag(:span, title, class: "#{base_class} octicon-#{name}")
      end

      def require_mark
        content_tag(:span, "require", class: "label label-danger")
      end

      def datetime_to_s(datetime, format = :default)
        I18n.l(datetime.in_time_zone, format: "%Y/%m/%d %H:%M:%S %z")
      end
    end

    helpers ApplicationHelper
  end
end
