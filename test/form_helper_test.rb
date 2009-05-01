require 'test_helper'

class FormHelperTest < EaselHelpers::ViewTestCase
  
  context "submit_button" do
    
    should "default with the correct structure" do
      show_view "<%= submit_button 'Create' %>" do
        assert_select "button.btn[type=submit]" do
          assert_select "span", "Create"
        end
      end
    end
    
    should "allow adding additional classes" do
      show_view "<%= submit_button 'Create', 'adtl-class', :dumb %>" do
        assert_select "button.btn.adtl-class.dumb[type=submit]" do
          assert_select "span", "Create"
        end
      end
    end
    
    should "handle additional attributes set" do
      show_view "<%= submit_button 'Create', :kls, :id => 'my-id', :type => 'image' %>" do
        assert_select "button.btn.kls#my-id[type=image]" do
          assert_select "span", "Create"
        end
      end
    end
    
  end
  
  context "set" do
    
    should "default with the correct structure" do
      show_view "<% set do %>words<% end %>" do
        assert_select "div.text", "words"
      end
    end
    
    should "allow adding/overriding classes" do
      show_view "<% set :checkbox do %>words<% end %>" do
        assert_select "div.checkbox", "words"
      end
    end
    
    should "handle additional attributes set" do
      show_view "<% set :id => 'custom-id' do %>words<% end %>" do
        assert_select "div.text#custom-id", "words"
      end
    end
    
    should "assign default class if width class is passed as the only class" do
      show_view "<% set :half do %>words<% end %>" do
        assert_select "div.text.col-12", "words"
      end
    end
    
  end
  
  context "fieldset" do
    
    should "default with the correct structure" do
      show_view "<% fieldset do %>words<% end %>" do
        assert_select "fieldset", "words"
      end
    end
    
    should "assign the first argument as the legend if it is a string" do
      show_view "<% fieldset 'User Information' do %>words<% end %>" do
        assert_select "fieldset", /words/ do
          assert_select "h3.legend", "User Information"
        end
      end
    end
    
    should "allow adding fieldset classes" do
      show_view "<% fieldset :hform, 'col-last' do %>words<% end %>" do
        assert_select "fieldset.hform.col-last", "words"
      end
    end
    
    should "allow adding fieldset classes and a legend" do
      show_view "<% fieldset 'User Information', :hform, 'col-last' do %>words<% end %>" do
        assert_select "fieldset.hform.col-last", /words/ do
          assert_select "h3.legend", "User Information"
        end
      end
    end
    
    should "allow assignment of legend attributes" do
      show_view "<% fieldset 'User Information', :hform, :legend => {:class => 'lgnd', :id => 'legend-id'} do %>words<% end %>" do
        assert_select "fieldset.hform", /words/ do
          assert_select "h3.legend.lgnd#legend-id", "User Information"
        end
      end
    end
    
    should "allow assignment of fieldset attributes" do
      show_view "<% fieldset 'User Information', :hform, :id => 'my-fieldset' do %>words<% end %>" do
        assert_select "fieldset.hform#my-fieldset", /words/ do
          assert_select "h3.legend", "User Information"
        end
      end
    end
    
  end
  
end