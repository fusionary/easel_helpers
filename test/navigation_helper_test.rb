require "test_helper"

class NavigationHelperTest < ActiveSupport::TestCase
  include EaselHelpers::Helpers::NavigationHelper

  context "tab" do
    should "parse tab options properly" do
      expects(:parse_tab_options).with("test", {:b => 2}).returns({})
      stubs(:link_to)
      stubs(:content_tag)
      stubs(:clean_css_classes)
      tab("test", "/", {:a => 1}, {:b => 2})
    end

    should "call link_to properly" do
      stubs(:content_tag)
      stubs(:clean_css_classes)
      stubs(:parse_tab_options).returns({})
      expects(:link_to).with("test", "/path", {:a => 1, :b => 2})
      tab("test", "/path", {:a => 1, :b => 2})
    end

    context "compiling li classes" do
      setup do
        @result_options = { :active => "1",
                            :comparison => "2",
                            :compare => false,
                            :li_classes => "one two three" }
        stubs(:link_to).returns("link_to")
        stubs(:content_tag)
      end

      should "properly use classes passed in the options" do
        stubs(:parse_tab_options).returns(@result_options)
        expects(:clean_css_classes).with(["one two three", nil])
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

      should "not assign class if css_classes is blank" do
        @result_options[:li_classes] = nil
        stubs(:parse_tab_options).returns({})
        stubs(:clean_css_classes).returns("")
        expects(:content_tag).with(:li, "link_to", {})
        tab("test", "/")
      end
    end

    context "parse_tab_options" do
    end
  end
end
