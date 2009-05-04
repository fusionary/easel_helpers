require 'test_helper'

class TableHelperTest < EaselHelpers::ViewTestCase
  
  context "zebra_row" do
    
    should "default with the correct structure" do
      show_view "<table><% zebra_row do %>no class<% end %><% zebra_row do %>alt class<% end %></table>" do
        assert_select "tr:first-child", "no class"
        assert_select "tr.alt:last-child", "alt class"
      end
    end
    
    should "allow override of the cycle list" do
      show_view %(
        <table>
          <% (colors = %w(red white blue)).each do |color| %>
            <% zebra_row :cycle_list => colors do %>the color <%= color %><% end %>
          <% end %>
        </table>
      ) do
        assert_select "tr.red:first-child", "the color red"
        assert_select "tr.white", "the color white"
        assert_select "tr.blue:last-child", "the color blue"
      end
    end
    
    should "allow option assignment" do
      show_view "<% zebra_row :id => 'my-id', :class => 'custom-class' do %>user 1<% end %>" do
        assert_select "tr#my-id.custom-class", "user 1"
      end
    end
    
  end
  
end