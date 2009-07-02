require 'test_helper'

class MessageHelperTest < EaselHelpers::ViewTestCase

  context "messages" do

    should "default with the correct structure" do
      show_view %(<%= messages(:structure => "Flash message") %>) do
        assert_select "p.structure.box.single-line", "Flash message"
      end
    end

    should "display all flash messages present" do
      show_view %(<%= messages(:structure => "Flash message", :error => "Warning message") %>) do
        assert_select "p.structure", "Flash message"
        assert_select "p.error", "Warning message"
      end
    end

    should "not display a flash if it is blank" do
      show_view %(<%= messages(:structure => "", :error => nil) %>) do
        assert_select "p.structure", false
        assert_select "p.error", false
      end
    end

    should "filter by the :only option" do
      show_view %(<%= messages({:structure => "Flash message", :error => "Warning message", :notice => "Notice!"}, {:only => [:structure, :error]}) %>) do
        assert_select "p.structure", "Flash message"
        assert_select "p.error", "Warning message"
        assert_select "p.notice", false
      end
    end

    should "filter by the :except option" do
      show_view %(<%= messages({:structure => "Flash message", :error => "Warning message", :notice => "Notice!"}, {:except => [:structure, :error]}) %>) do
        assert_select "p.structure", false
        assert_select "p.error", false
        assert_select "p.notice", "Notice!"
      end
    end

    should "raise an error of :only and :except are both passed" do
      assert_raise ArgumentError, /conflict/ do
        show_view %(<%= messages({:structure => "Flash message"}, {:except => [:structure, :error], :only => :structure}) %>)
      end
    end
  end

end
