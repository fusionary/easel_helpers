require "easel_helpers/helpers/date_helper"
require "easel_helpers/helpers/form_helper"
require "easel_helpers/helpers/link_helper"
require "easel_helpers/helpers/structure_helper"
require "easel_helpers/helpers/table_helper"
require "easel_helpers/helpers/grid_helper"

module EaselHelpers
  module Helpers
    include DateHelper
    include FormHelper
    include LinkHelper
    include StructureHelper
    include TableHelper
    include GridHelper
    
    protected
    
    def clean_css_classes(string_or_array, replace = {})
      returning [] do |css_classes|
        css_classes << [string_or_array].flatten.join(" ")
        css_classes = css_classes.split(/ /).map(&:strip).uniq.join(" ").strip
        
        replace.keys.each do |k|
          if css_classes.include? k
            css_classes.delete(k)
            css_classes << replace[k]
          end
        end
      end
    end
    
    private
    
    BLOCK_CALLED_FROM_ERB = 'defined? __in_erb_template'
    
    if RUBY_VERSION < '1.9.0'
      # Check whether we're called from an erb template.
      # We'd return a string in any other case, but erb <%= ... %>
      # can't take an <% end %> later on, so we have to use <% ... %>
      # and implicitly concat.
      def block_is_within_action_view?(block)
        block && eval(BLOCK_CALLED_FROM_ERB, block)
      end
    else
      def block_is_within_action_view?(block)
        block && eval(BLOCK_CALLED_FROM_ERB, block.binding)
      end
    end
    
  end
end