module EaselHelpers
  module Helpers
    module JqueryHelper

      def document_ready(&block)
        html = content_tag :script, :type => "text/javascript" do
          %(
            (function($) {
              $(document).ready(function() {
                #{capture(&block)}
              });
            })(jQuery);
          )
        end

        concat(html)
      end

    end
  end
end
