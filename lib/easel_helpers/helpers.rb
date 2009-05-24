require "easel_helpers/helpers/date_helper"
require "easel_helpers/helpers/form_helper"
require "easel_helpers/helpers/link_helper"
require "easel_helpers/helpers/structure_helper"
require "easel_helpers/helpers/table_helper"
require "easel_helpers/helpers/grid_helper"
require "easel_helpers/helpers/flash_helper"

module EaselHelpers
  module Helpers
    include DateHelper
    include FormHelper
    include LinkHelper
    include StructureHelper
    include TableHelper
    include GridHelper
    include FlashHelper
    
    protected
    
    def other_than_grid?(classes)
      (standardize_css_classes(classes).map {|s| s.to_s } - EaselHelpers::Helpers::GridHelper::MULTIPLE_FRACTIONS).any?
    end
    
    def clean_css_classes(string_or_array, replace = {})
      css_classes = [] + standardize_css_classes(string_or_array)
      
      if replace.any?
        replace.keys.each do |k|
          if css_classes.include? k
            css_classes.delete(k)
            css_classes << replace[k]
          end
        end
      end
      
      if css_classes.any? && (fractions = css_classes & EaselHelpers::Helpers::GridHelper::MULTIPLE_FRACTIONS).any?
        fractions.each do |f|
          css_classes.delete(f)
          css_classes << self.send(f)
          css_classes << last_column if f == "full" && @_easel_column_count != application_width
        end
      end
      
      css_classes.map {|s| s.strip }.reject {|s| s.blank? }.uniq.join(" ").strip
    end
    
    private
    
    def standardize_css_classes(string_or_array)
      [string_or_array].flatten.join(" ").split(/ /)
    end
    
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