require 'test_helper'

class JqueryHelperTest < EaselHelpers::ViewTestCase

  context "document_ready" do

    setup do
      @whitespace = '\s+?'
      @anything =   '(.|\s)+?'

      @anon_function_start_regex  = Regexp.escape "(function($) {"
      @document_ready_start_regex = Regexp.escape   "$(document).ready(function() {"

      @document_ready_end_regex   = Regexp.escape   "});"
      @anon_function_end_regex    = Regexp.escape "})(jQuery);"
    end

    should "properly build the document ready script tag" do
      show_view %(
        <% document_ready do %>
          alert("hello!");
        <% end %>
      ) do
        assert_select "script[type=?]", "text/javascript", /#{@anon_function_start_regex}#{@whitespace}#{@document_ready_start_regex}#{@whitespace}alert#{@anything}#{@document_ready_end_regex}#{@whitespace}#{@anon_function_end_regex}/
      end
    end

  end

end
