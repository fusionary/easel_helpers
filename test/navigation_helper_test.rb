require "test_helper"

class NavigationHelperTest < ActiveSupport::TestCase
  include EaselHelpers::Helpers
  include EaselHelpers::Helpers::NavigationHelper

  context "tab" do
    should "parse tab options properly" do
      expects(:parse_tab_options).with("test", {:b => 2}).returns({})
      stubs(:link_to)
      stubs(:content_tag)
      tab("test", "/", {:a => 1}, {:b => 2})
    end

    context "compiling li classes" do
      setup do
        @result_options = {
                            :active => "1",
                            :comparison => "2",
                            :compare => false,
                            :li_classes => "one two three"
                          }
        stubs(:link_to)
        stubs(:content_tag)
      end

      should "properly use classes passed in the options" do
        stubs(:parse_tab_options).returns(@result_options)
        expects(:clean_css_classes).with(["one two three"])
        tab("test", "/")
      end

      should "properly compare information" do
        @result_options[:comparison] = "1"
        stubs(:parse_tab_options).returns(@result_options)
        expects(:clean_css_classes).with(["one two three", "active"])
        tab("test", "/")
      end

      should "properly use compare value" do
        @result_options[:compare] = true
        stubs(:parse_tab_options).returns(@result_options)
        expects(:clean_css_classes).with(["one two three", "active"])
        tab("test", "/")
      end
    end

    context "parse_tab_options" do
    end
  end
end
