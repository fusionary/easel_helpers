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
  
  context "body" do
    
    should "allow passing a block structure" do
      show_view %(
        <% body do %>body goes here<% end %>
      ) do
        assert_select "body", "body goes here"
      end
    end
    
    should "allow passing arguments" do
      show_view %(
        <% body :home, 'home-index', 'logged-in', :id => 'application' do %>body goes here<% end %>
      ) do
        assert_select "body#application.home.home-index.logged-in", "body goes here"
      end
    end
    
    should "allow multiple body definitions that set attributes" do
      show_view %(
        <% body :home, 'logged-in' %>
        <% body :id => 'application' %>
        <% body 'home-index', :id => 'application-override' do %>body goes here<% end %>
      ) do
        assert_select "body#application-override.home.home-index.logged-in", "body goes here"
      end
    end
    
  end
  
end