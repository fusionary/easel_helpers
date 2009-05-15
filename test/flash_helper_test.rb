require 'test_helper'

class FlashHelperTest < EaselHelpers::ViewTestCase
  
  context "render_flash" do
    
    should "default with the correct structure" do
      show_view %(<%= render_flash(:structure => "Flash message") %>) do
        assert_select "p.structure.box.single-line", "Flash message"
      end
    end
    
    should "display all flash messages present" do
      show_view %(<%= render_flash(:structure => "Flash message", :error => "Warning message") %>) do
        assert_select "p.structure.box.single-line", "Flash message"
        assert_select "p.error.box.single-line", "Warning message"
      end
    end
    
    should "not display a flash if it is blank" do
      show_view %(<%= render_flash(:structure => "", :error => nil) %>) do
        assert_select "p.structure.box.single-line", false
        assert_select "p.error.box.single-line", false
      end
    end
    
  end
  
end