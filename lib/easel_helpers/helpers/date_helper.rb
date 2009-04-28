module EaselHelpers
  module Helpers
    module DateHelper
      def datetime(dt = nil, default_text = "", format_string = :long)
        dt ? dt.to_time.to_s(format_string) : default_text
      end

      def date(dt = nil, default_text = "", format_string = :long)
        dt ? dt.to_date.to_s(format_string) : default_text
      end
    end
  end
end