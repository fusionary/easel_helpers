module EaselHelpers
  module Helpers
    module TableHelper

      def zebra_row(options = {}, &block)
        cycle_list = options.delete(:cycle_list) || [nil, "alt"]
        css_classes = [cycle(*cycle_list)] << options.delete(:class)
        css_classes = clean_css_classes(css_classes)

        html = content_tag :tr,
                           capture(&block),
                           options.merge(:class => css_classes)
        concat(html)
      end

      def recordset(*args, &block)
        options = args.extract_options!
        options[:table] ||= {}

        headers = []
        (options[:headers] || []).each_with_index do |header, index|
          head = [header].flatten
          opts = head.extract_options!

          css_classes = [] << opts.delete(:class) << case index
            when 0 then "first"
            when (options[:headers].size - 1) then "last"
          end

          headers << if head.first =~ /^\<th/
            th = Hpricot(head.first)
            th_classes = th.at("th")["class"].join
            th_classes = clean_css_classes([th_classes, css_classes])
            th.at("th")["class"] = th_classes
            th.to_html
          else
            content_tag :th,
                        head.first,
                        opts.merge(:class => clean_css_classes(css_classes))
          end
        end

        table_classes = ["recordset", args] << options[:table].delete(:class)
        css_classes = clean_css_classes(table_classes, {"last" => last_column})

        html =  clean_column(css_classes) do
          table_options = options[:table]
          table_options.merge!(:class => css_classes, :cellspacing => 0)
          content_tag(:table,
                      content_tag(:thead, content_tag(:tr, headers.join)) + \
                        capture(&block),
                      table_options)
        end

        reset_cycle
        concat(html)
      end

    end
  end
end
