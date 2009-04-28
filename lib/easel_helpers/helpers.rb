require "easel_helpers/helpers/date_helper"
require "easel_helpers/helpers/form_helper"
require "easel_helpers/helpers/link_helper"
require "easel_helpers/helpers/structure_helper"
require "easel_helpers/helpers/table_helper"

module EaselHelpers
  module Helpers
    include DateHelper
    include FormHelper
    include LinkHelper
    include StructureHelper
    include TableHelper
    
    protected
    
    def clean_css_classes(string_or_array)
      css_classes = [string_or_array].flatten.join(" ")
      css_classes.split(/ /).map(&:strip).uniq.join(" ").strip
    end
  end
  
end