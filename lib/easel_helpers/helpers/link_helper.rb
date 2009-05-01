module EaselHelpers
  module Helpers
    module LinkHelper
      def link_button(*args, &block)
        doc = Hpricot(link_to(*args, &block))
        doc.at("a").inner_html = "<span>#{doc.at("a").inner_html}</span>"
        (doc/:a).add_class("btn")
        doc.to_html
      end
      
      def link_to_email(email_address, *args)
        options = args.extract_options!
        link = args.first.is_a?(String) ? h(args.first) : email_address
        return link if email_address.blank?
        link_to link, "mailto:#{email_address}", options
      end
      
    end
  end
end