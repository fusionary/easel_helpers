module EaselHelpers
  module Helpers
    module NavigationHelper
      def tab(name, path, options = {}, li_options = {})
        opts = parse_tab_options(name, li_options)
        active, comparison, compare, li_classes = \
          opts[:active], opts[:comparison], opts[:compare], opts[:li_classes]

        css_classes = [] << li_classes
        css_classes << "active" if (active == comparison) || compare
        css_classes = clean_css_classes(css_classes)
        content_tag :li,
                    link_to(name, path, options),
                    li_options.merge(:class => (css_classes.blank? ? nil : css_classes))
      end

      private

      def parse_tab_options(name, li_options = {})
        returning({}) do |result|
          result[:active]     = li_options.delete(:active) || (name.gsub(/\s/, '').tableize || "")
          result[:comparison] = li_options.delete(:active_compare) || controller.controller_name
          result[:compare]    = li_options.delete(:compare) || false
          result[:li_classes] = li_options.delete(:class)
        end
      end
    end
  end
end
