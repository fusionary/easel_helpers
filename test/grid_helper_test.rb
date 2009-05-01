require 'test_helper'

class GridHelperTest < EaselHelpers::ViewTestCase
  test "a basic structure can be generated" do
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
end
