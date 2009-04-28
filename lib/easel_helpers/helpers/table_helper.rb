module EaselHelpers
  module Helpers
    module TableHelper
    
      def zebra_row(options = {}, &block)
        cycle_list = options.delete(:cycle_list) || [nil, "alt"]
        css_classes = [cycle(*cycle_list)] << options.delete(:class)
        html = content_tag(:tr, capture(&block),
          options.merge(:class => clean_css_classes(css_classes)))
        concat(html)
      end
      
      def recordset(*args, &block)
        options = args.extract_options!
        options[:table] ||= {}
        
        headers = []
        options[:headers].each_with_index do |header, index|
          head = [header].flatten
          opts = head.extract_options!
          
          css_classes = [] << case index
            when 0 then "first"
            when (options[:headers].size - 1) then "last"
          end
          
          css_classes << opts.delete(:class)
          
          headers << if head.first =~ /^\<th/
            th = Hpricot(head.first)
            th.at("th")["class"] = clean_css_classes([th.at("th")['class'].to_s, css_classes])
            th.to_html
          else
            content_tag(:th, head.first, opts.merge(:class => clean_css_classes(css_classes)))
          end
        end
        
        table_css_classes = ["recordset"] << options[:table].delete(:class) << args
        
        html =  content_tag(:table, 
                  content_tag(:thead, content_tag(:tr, headers.to_s)) + capture(&block), 
                    options[:table].merge(:class => clean_css_classes(table_css_classes)))
        concat(html)
      end
      
    end
  end
end