module EaselHelpers
  module Helpers
    module FlashHelper
      
      def render_flash(flash)
        flash.keys.map do |key|
          content_tag :p, flash[key], :class => [key, "box", "single-line"].join(" ") unless flash[key].blank?
        end.join
      end
      
    end
  end
end