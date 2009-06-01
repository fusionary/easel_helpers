require 'test_helper'

class RjsHelperTest < ActiveSupport::TestCase
  include EaselHelpers::Helpers::RjsHelper
  include EaselHelpers::Helpers::FlashHelper
  
  context "inline_flash" do
    setup do
      @page = Object.new
      self.expects(:render_flash).with({:notice => "Test!"}).returns("string")
    end
    
    should "default to inserting flash within div#flash-container" do
      @page.expects(:insert_html).with(:top, "flash-container", "string")
      inline_flash(@page, {:notice => "Test!"})
    end
    
    should "allow assignment of container id" do
      @page.expects(:insert_html).with(:top, "my-custom-id", "string")
      inline_flash(@page, {:notice => "Test!"}, {:container => "my-custom-id"})
    end
    
    should "allow replacement of current flash container's HTML" do
      @page.expects(:replace_html).with("flash-container", "string")
      inline_flash(@page, {:notice => "Test!"}, {:replace => true})
    end
  end
  
end