module EaselHelpers
  module Helpers
    module RjsHelper
      
      def inline_flash(page, flash, options = {})
        container_id = options[:container] || "flash-container"
        
        if options[:replace]
          page.replace_html container_id, messages(flash)
        else
          page.insert_html :top, container_id, messages(flash)
        end
      end
      
    end
  end
end