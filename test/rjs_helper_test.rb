require 'test_helper'

class RjsHelperTest < ActiveSupport::TestCase
  include EaselHelpers::Helpers::RjsHelper
  include EaselHelpers::Helpers::MessageHelper

  context "inline_flash" do
    setup do
      @page = Object.new
      @flash_hash = {:notice => "Test!"}
      self.expects(:messages).with({:notice => "Test!"}).returns("string")
    end

    context "without keeping flash" do
      setup do
        @flash_hash.expects(:discard).returns(true)
      end

      should "default to inserting flash within div#flash-container" do
        @page.expects(:insert_html).with(:top, "flash-container", "string")
        inline_flash(@page, @flash_hash)
      end

      should "allow assignment of container id" do
        @page.expects(:insert_html).with(:top, "my-custom-id", "string")
        inline_flash(@page, @flash_hash, {:container => "my-custom-id"})
      end

      should "allow replacement of current flash container's HTML" do
        @page.expects(:replace_html).with("flash-container", "string")
        inline_flash(@page, @flash_hash, {:replace => true})
      end
    end

    context "when keeping flash" do
      setup do
        @flash_hash.expects(:discard).never
      end

      should "default to inserting flash within div#flash-container" do
        @page.expects(:insert_html).with(:top, "flash-container", "string")
        inline_flash(@page, @flash_hash, :keep_flash => true)
      end
    end
  end

end
