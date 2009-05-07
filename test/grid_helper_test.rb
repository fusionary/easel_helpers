require 'test_helper'

class GridHelperTest < EaselHelpers::ViewTestCase
  should "properly assign classes for a simple column layout" do
    template = %(
      <% container do %>
        <% column do %>
          <% column :half do %>
            <% column :one_third do %>
              one third of one half of 24 is 4
            <% end %>
            <% column :one_third, :last, prepend_one_third do %>
              one third of one half of 24 is 4 (but prepended 4 as well)
            <% end %>
            <hr/>
            more text
          <% end %>
          <% column :half, :last do %>
            second column
          <% end %>
          <hr/>
          text
        <% end %>
      <% end %>
    )
    
    show_view template do
      assert_select ".container", 1
      assert_select ".col-24", 1
      assert_select ".col-12", 2
      assert_select ".col-4", 2
      assert_select ".prepend-4", 1
      assert_select ".col-24.col-last", 0
      assert_select ".col-12.col-last", 1
      assert_select ".col-4.col-last", 1
      assert_select "hr", 2
    end
  end
  
  should "properly assign classes for generic helpers" do
    template = %(
      <% column do %>
        <% fieldset :hform, :half do %>
          <% set :one_third do %>text<% end %>
          <% set :two_thirds, :last do %>more text<% end %>
        <% end %>
        <% recordset :half, :last do %>table<% end %>
      <% end %>
    )
    
    show_view template do
      assert_select "div.col-24" do
        assert_select "fieldset.hform.col-12" do
          assert_select "div.col-4", "text"
          assert_select "div.col-8.col-last", "more text"
        end
        assert_select "table.col-12.col-last", "table"
      end
    end
  end
  
  should "properly assign classes for a deeply-nested view" do
    template = %(
      <% container do %>
        <% column :half do %>
          <% fieldset :hform, :half do %>
            <% set :one_third do %>text<% end %>
            <% set :two_thirds, :last do %>more text<% end %>
          <% end %>
          <% recordset :half, :last do %>table<% end %>
        <% end %>
        <% column :one_third do %>one third!<% end %>
        <% column :one_sixth, :last do %>
          <% fieldset :vform, :full, :last  do %>
            <% set do %>text<% end %>
          <% end %>
        <% end %>
      <% end %>
    )
    
    show_view template do
      assert_select "div.container" do
        assert_select "div.col-12" do
          assert_select "fieldset.hform.col-6" do
            assert_select "div.col-2", "text"
            assert_select "div.col-4.col-last", "more text"
          end
          assert_select "table.col-6.col-last", "table"
        end
        
        assert_select "div.col-8", "one third!"
        
        assert_select "div.col-4.col-last" do
          assert_select "fieldset.vform.col-4.col-last" do
            assert_select "div", "text"
          end
        end
        
      end
    end
  end
end
