module EaselHelpers
  module Helpers
    module MessageHelper

      def messages(messages, options = {})
        except_keys = [options[:except]].flatten.compact
        only_keys   = [options[:only]].flatten.compact

        if except_keys.any? && only_keys.any?
          raise ArgumentError, ":only and :except options conflict; use one"
        end

        keys = if except_keys.any?
          messages.keys - except_keys
        elsif only_keys.any?
          messages.keys & only_keys
        else
          messages.keys
        end

        keys.map do |key|
          if messages[key].present?
            content_tag :p,
                        messages[key],
                        :class => [key, "box", "single-line"].join(" ")
          end
        end.join
      end

    end
  end
end
