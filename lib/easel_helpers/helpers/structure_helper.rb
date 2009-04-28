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
    
    end
  end
end