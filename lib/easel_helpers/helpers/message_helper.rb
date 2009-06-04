module EaselHelpers
  module Helpers
    module MessageHelper
      
      def messages(messages, options = {})
        except_keys = [options[:except]].flatten.compact
        only_keys = [options[:only]].flatten.compact
        
        raise ArgumentError, ":only and :except options conflict; use one or the other" if except_keys.any? && only_keys.any?
        
        keys = if except_keys.any?
          messages.keys - except_keys
        elsif only_keys.any?
          messages.keys & only_keys
        else
          messages.keys
        end
        
        keys.map do |key|
          content_tag :p, messages[key], :class => [key, "box", "single-line"].join(" ") unless messages[key].blank?
        end.join
      end
      
    end
  end
end