module EaselHelpers
  module Helpers
    module StructureHelper
      
      def blockquote(*args, &block)
        options = args.extract_options!
        author = options.delete(:author)
        
        bq =  content_tag(:blockquote,
                (option_quote = textilize(options.delete(:quote))).blank? ? capture(&block) : option_quote
              )
        
        html = if author
          content_tag(:div, bq + content_tag(:cite, author), :class => "quote-cited")
        else
          bq
        end
        
        concat(html)
      end
      
      def body(*args)
        options = args.extract_options!
        @_page_body_attributes ||= {}
        
        css_classes = [] << @_page_body_attributes.delete(:class) << args
        @_page_body_attributes = @_page_body_attributes.merge(options)
        @_page_body_attributes[:class] = clean_css_classes(css_classes)
        
        if block_given?
          block = lambda { yield }
          html = content_tag(:body, capture(&block), @_page_body_attributes)
          concat(html)
        end
      end
      
    end
  end
end