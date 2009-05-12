module EaselHelpers
  module Helpers
    module FormHelper
      
      def submit_button(value, *args)
        options = args.extract_options!
        css_classes = ["btn"] << options.delete(:class) << args
        content_tag(:button, "<span>#{value}</span>", {:value => value, :type => "submit", :class => clean_css_classes(css_classes, {"last" => last_column})}.merge(options))
      end
      
      def set(*args, &block)
        options = args.extract_options!
        css_classes = [] << options.delete(:class) << args
        css_classes << "text" unless other_than_grid?(args.map(&:to_s) - ["last", last_column.to_s])
        css_classes << "text" if standardize_css_classes(css_classes).include?("textarea")
        
        css_classes = clean_css_classes(css_classes, {"last" => last_column})
        
        html = clean_column css_classes do
          content_tag(:div, capture(&block), options.merge(:class => css_classes))
        end
        
        concat(html)
      end
      
      def fieldset(*args, &block)
        options = args.extract_options!
        css_classes = [] << options.delete(:class) << args
        title = args.shift if args.first.is_a?(String)
        legend = if title.blank?
          ""
        else
          legend_opts = options.delete(:legend) || {}
          content_tag(:h3, 
            title, 
            {:class => clean_css_classes([legend_opts.delete(:class)] << "legend")}.merge(legend_opts))
        end
        
        css_classes = clean_css_classes(css_classes, {"last" => last_column})
        
        html = clean_column css_classes do
          content_tag(:fieldset, legend + capture(&block), options.merge(:class => css_classes))
        end
        
        concat(html)
      end
      
    end
  end
end