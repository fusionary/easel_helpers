module EaselHelpers
  module Helpers
    module FlashHelper
      
      def render_flash(flash, options = {})
        except_keys = [options[:except]].flatten.compact
        only_keys = [options[:only]].flatten.compact
        
        raise ArgumentError, ":only and :except options conflict; use one or the other" if except_keys.any? && only_keys.any?
        
        keys = if except_keys.any?
          flash.keys - except_keys
        elsif only_keys.any?
          flash.keys & only_keys
        else
          flash.keys
        end
        
        keys.map do |key|
          content_tag :p, flash[key], :class => [key, "box", "single-line"].join(" ") unless flash[key].blank?
        end.join
      end
      
    end
  end
end