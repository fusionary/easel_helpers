require 'test_helper'

class FormHelperTest < EaselHelpers::ViewTestCase
  context "submit_button" do
    should "default with the correct structure" do
      show_view "<%= submit_button 'Create' %>" do
        assert_select "button.btn[type=submit]", 1
        assert_select "button span", 1
      end
    end
    
    should "allow adding additional classes" do
      show_view "<%= submit_button 'Create', 'adtl-class', :dumb %>" do
        assert_select "button.btn.adtl-class.dumb[type=submit]", 1
        assert_select "button span", 1
      end
    end
    
    should "handle additional attributes set" do
      show_view "<%= submit_button 'Create', :kls, :id => 'my-id', :type => 'image' %>" do
        assert_select "button.btn.kls#my-id[type=image]", 1
        assert_select "button span", 1
      end
    end
  end
  
  context "set" do
    should "default with the correct structure" do
      show_view "<% set do %>words<% end %>" do
        assert_select "div.text", {:count => 1, :text => "words"}
      end
    end
    
    should "allow adding/overriding classes" do
      show_view "<% set :checkbox do %>words<% end %>" do
        assert_select "div.checkbox", {:count => 1, :text => "words"}
      end
    end
    
    should "handle additional attributes set" do
      show_view "<% set :id => 'custom-id' do %>words<% end %>" do
        assert_select "div.text#custom-id", {:count => 1, :text => "words"}
      end
    end
    
    should "assign default class if width class is passed as the only class" do
      show_view "<% set :half do %>words<% end %>" do
        assert_select "div.text.col-12", {:count => 1, :text => "words"}
      end
    end
  end
end
