require 'test_helper'

class TableHelperTest < EaselHelpers::ViewTestCase
  
  context "zebra_row" do
    
    should "default with the correct structure" do
      show_view "<% zebra_row do %>no class<% end %><% zebra_row do %>alt class<% end %>" do
        assert_select "tr", 2
        assert_select "tr.alt", 1
        assert_select "tr", "no class"
        assert_select "tr.alt", "alt class"
      end
    end
    
  end
  
end