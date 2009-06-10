module EaselHelpers
  module Helpers
    module RjsHelper
      
      def inline_flash(page, flash, options = {})
        container_id = options[:container] || "flash-container"
        current_flash = flash
        
        flash.discard unless options[:keep_flash]
        
        if options[:replace]
          page.replace_html container_id, messages(current_flash)
        else
          page.insert_html :top, container_id, messages(current_flash)
        end
      end
      
    end
  end
end