module EaselHelpers
  module Helpers
    module GridHelper
      MULTIPLES = {
        :one_twentyfourth =>          (1/24.to_f),
        :one_twelfth =>               (1/12.to_f),
        :one_eigth =>                 (1/8.to_f),
        :one_sixth =>                 (1/6.to_f),
        :five_twentyfourths =>        (5/24.to_f),
        :one_fourth =>                (1/4.to_f),
        :seven_twentyfourths =>       (7/24.to_f),
        :one_third =>                 (1/3.to_f),
        :three_eigths =>              (3/8.to_f),
        :five_twelfths =>             (5/12.to_f),
        :eleven_twentyfourths =>      (11/24.to_f),
        :one_half =>                  (1/2.to_f),
        :half =>                      (1/2.to_f),
        :thirteen_twentyfourths =>    (13/24.to_f),
        :seven_twelfths =>            (7/12.to_f),
        :five_eigths =>               (5/8.to_f),
        :two_thirds =>                (2/3.to_f),
        :seventeen_twentyfourths =>   (17/24.to_f),
        :three_fourths =>             (3/4.to_f),
        :nineteen_twentyfourths =>    (19/24.to_f),
        :five_sixths =>               (5/6.to_f),
        :seven_eigths =>              (7/8.to_f),
        :eleven_twelfths =>           (11/12.to_f),
        :twentythree_twentyfourths => (23/24.to_f),
        :full =>                      (1.to_f)
      }.freeze
      MULTIPLE_FRACTIONS = MULTIPLES.keys.map {|k| k.to_s }.freeze
      
      def last_column
        "col-last"
      end
      
      def column(*args, &block)
        @_easel_column_count ||= application_width
        col(*args, &block)
      end
      
      def container(size=nil, *args, &block)
        args = args.insert(0, :container)
        column(size, *args, &block)
      end
      
      def clean_column(classes, &block)
        size = classes.scan(/col-(\d+)/).flatten.last
        
        if size.nil?
          html = capture(&block)
          if block_given? && block_is_within_action_view?(block)
            concat(html)
          else
            html
          end
        else
          size = size.to_i
          increase_depth(size)
          html = capture(&block)
          
          if block_given? && block_is_within_action_view?(block)
            concat(html)
            decrease_depth(size)
          else
            decrease_depth(size)
            html
          end
        end
      end
      
      def method_missing_with_easel_widths(call, *args)
        # filter out any initial helper calls
        found = false
        MULTIPLE_FRACTIONS.each do |w|
          found = true and break if call.to_s.include?(w)
        end
        method_missing_without_easel_widths(call, *args) and return unless found
        
        # one of the widths is somewhere in the helper call; let's find it
        call.to_s =~ /^((append|prepend|col)_)?(.+)$/
        class_name = $2 || "col"
        class_width = $3
        
        if MULTIPLES.keys.include?(class_width.to_sym)
          width = @_easel_column_count || application_width
          "#{class_name}-#{(width*MULTIPLES[class_width.to_sym]).to_i}"
        else
          method_missing_without_easel_widths(call, *args)
        end
      end
      
      alias_method_chain :method_missing, :easel_widths
      
      private
      
      def application_width; 24; end
      
      def increase_depth(size)
        @_easel_current_width ||= [application_width.to_s]
        @_easel_current_width.push @_easel_column_count.to_s unless @_easel_column_count.blank?
        @_easel_column_count = size.to_s =~ /^\d+$/ ? size.to_s.to_i : (@_easel_column_count*MULTIPLES[size]).to_i
      end
      
      def decrease_depth(size)
        @_easel_column_count = size.is_a?(Integer) ? @_easel_current_width.last.to_i : (@_easel_column_count/MULTIPLES[size]).to_i
        @_easel_current_width.pop
      end
      
      def col(*args, &block)
        size = (MULTIPLE_FRACTIONS.include?(args.first.to_s) || args.first.is_a?(Integer)) ? args.shift : :full
        
        increase_depth(size)
        output_tag = generate_output_tag(size, *args, &block)
        
        if block_given? && block_is_within_action_view?(block)
          concat(output_tag)
          decrease_depth(size)
        else
          decrease_depth(size)
          output_tag
        end
      end
      
      def generate_output_tag(size, *args, &block)
        options = args.extract_options!
        
        css_classes = [] << options.delete(:class) << args
        css_classes << "col-#{@_easel_column_count}" unless options.delete(:suppress_col)
        css_classes << last_column if size.to_sym == :full && @_easel_column_count != application_width
        
        content_tag(:div, capture(&block), {:class => clean_css_classes(css_classes, {"last" => last_column})}.merge(options))
      end
      
    end
  end
end