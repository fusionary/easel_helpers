module EaselHelpers
  module Helpers
    module FormHelper
      
      def submit_button(value)
        content_tag(:button, "<span>#{value}</span>", :class => "btn", :type => "submit")
      end
      
      def set(*args, &block)
        options = args.extract_options!
        css_classes = [] << options.delete(:class) << args
        css_classes << "text" unless args.any?
        
        html = content_tag(:div, capture(&block), options.merge(:class => clean_css_classes(css_classes)))
        concat(html)
      end
      
      def fieldset(*args, &block)
        options = args.extract_options!
        options[:legend] ||= {}
        css_classes = [] << options.delete(:class) << args
        title = args.shift if args.first.is_a?(String)
        legend = if title.blank?
          ""
        else
          content_tag(:h3, 
            title, 
            {:class => clean_css_classes([options[:legend].delete(:class)] << "legend")}.merge(options[:legend]))
        end
        
        html = content_tag(:fieldset, legend + capture(&block), options.merge(:class => clean_css_classes(css_classes)))
        concat(html)
      end
      
    end
  end
end