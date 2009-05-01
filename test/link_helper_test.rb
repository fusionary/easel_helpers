require 'test_helper'

class LinkHelperTest < EaselHelpers::ViewTestCase
  context "link_button" do
    
    should "default with the correct structure" do
      show_view "<%= link_button 'Link Text', '#' %>" do
        assert_select "a.btn[href=#]" do
          assert_select "span", "Link Text"
        end
      end
    end
    
    should "allow the same assignment as link_to" do
      show_view "<%= link_button 'Link Text', '#', :class => 'my-button', :id => 'link-text' %>" do
        assert_select "a.btn.my-button#link-text[href=#]" do
          assert_select "span", "Link Text"
        end
      end
    end
    
  end
  
  context "link_to_email" do
    should "default with the correct structure" do
      show_view "<%= link_to_email 'test@example.com' %>" do
        assert_select "a[href=mailto:test@example.com]", "test@example.com"
      end
    end
    
    should "allow override of link text as the first argument after email" do
      show_view "<%= link_to_email 'test@example.com', 'Send an email to Test User' %>" do
        assert_select "a[href=mailto:test@example.com]", "Send an email to Test User"
      end
    end
    
    should "allow the same assignment as link_to" do
      show_view "<%= link_to_email 'test@example.com', :class => 'test-user-email', :id => 'user_1_email' %>" do
        assert_select "a.test-user-email#user_1_email[href=mailto:test@example.com]", "test@example.com"
      end
    end
    
  end
end