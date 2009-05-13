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
  
  context "recordset" do
    
    should "default with the correct structure" do
      show_view %(<% recordset do %>rows<% end %>) do
        assert_select "table.recordset[cellspacing=0]", "rows"
      end
    end
    
    should "allow headers be set" do
      show_view %(<% recordset :headers => ["Header 1", "Header 2", "Header 3"] do %><tbody>rows</tbody><% end %>) do
        assert_select "table.recordset[cellspacing=0]" do
          assert_select "thead" do
            assert_select "tr" do
              assert_select "th.first", "Header 1"
              assert_select "th", "Header 2"
              assert_select "th.last", "Header 3"
            end
          end
          assert_select "tbody", "rows"
        end
      end
    end
    
    should "allow headers to have attributes set" do
      show_view %(
        <% recordset :headers => [["Header 1", {:class => "mine", :id => "over"}]] do %>
          <tbody>rows</tbody>
        <% end %>
      ) do
        assert_select "table.recordset[cellspacing=0]" do
          assert_select "thead" do
            assert_select "tr" do
              assert_select "th#over.first.mine", "Header 1"
            end
          end
          assert_select "tbody", "rows"
        end
      end
    end
    
    should "allow classes be assigned in a comma-delimited manner" do
      show_view %(<% recordset "my-recordset", "car-list" do %><% end %>) do
        assert_select "table.recordset.my-recordset.car-list[cellspacing=0]"
      end
    end
    
    should "allow additional attributes be set on the recordset" do
      show_view %(<% recordset :headers => %w(One Two Three), :table => {:id => "my-id", :class => "my-recordset"} do %><% end %>) do
        assert_select "table#my-id.recordset.my-recordset[cellspacing=0]" do
          assert_select "thead" do
            assert_select "tr" do
              assert_select "th", "One"
              assert_select "th", "Two"
              assert_select "th", "Three"
            end
          end
        end
      end
    end
    
    should "reset cycles for zebra_rows" do
      show_view %(
        <% recordset do %>
          <% zebra_row do %>text<% end %>
        <% end %>
        <% recordset do %>
          <% zebra_row do %>text<% end %>
        <% end %>
      ) do
        assert_select "table.recordset" do
          assert_select "tr.alt", 0
        end
      end
      
    end
  end
end