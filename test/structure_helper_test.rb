require 'test_helper'

class StructureHelperTest < EaselHelpers::ViewTestCase
  
  context "blockquote" do
    
    should "default with the correct structure" do
      show_view "<% blockquote do %>My quoted text<% end %>" do
        assert_select "blockquote", "My quoted text"
      end
    end
    
    should "default with the correct structure when an author is set" do
      show_view "<% blockquote :author => 'W. Shakespeare' do %>All the world's a stage<% end %>" do
        assert_select "div.quote-cited" do
          assert_select "blockquote", "All the world's a stage"
          assert_select "cite", "W. Shakespeare"
        end
      end
    end
    
  end
  
end