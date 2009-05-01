require 'test_helper'

class DateHelperTest < ActiveSupport::TestCase
  include EaselHelpers::Helpers::DateHelper
  
  context "datetime helper" do
    should "default to an empty string if date is not supplied" do
      assert_equal "", datetime(nil)
    end
    
    should "default to passed default text if date is not supplied" do
      assert_equal "default text", datetime(nil, "default text")
    end
    
    should "default to :long format for date" do
      timestamp = Time.now
      assert_equal timestamp.to_s(:long), datetime(timestamp)
    end
    
    should "use passed format if applicable" do
      timestamp = Time.now
      assert_equal timestamp.to_s(:short), datetime(timestamp, "", :short)
    end
    
    should "convert passed data to a time" do
      datestamp = Date.today
      timestamp = datestamp.to_time
      assert_equal timestamp.to_s(:long), datetime(datestamp)
    end
  end
  
  context "date helper" do
    should "default to an empty string if date is not supplied" do
      assert_equal "", date(nil)
    end
    
    should "default to passed default text if date is not supplied" do
      assert_equal "default text", date(nil, "default text")
    end
    
    should "default to :long format for date" do
      datestamp = Date.today
      assert_equal datestamp.to_s(:long), date(datestamp)
    end
    
    should "use passed format if applicable" do
      datestamp = Date.today
      assert_equal datestamp.to_s(:short), date(datestamp, "", :short)
    end
    
    should "convert passed data to a time" do
      timestamp = Time.now
      datestamp = timestamp.to_date
      
      assert_equal datestamp.to_s(:long), date(timestamp)
    end
  end
  
end