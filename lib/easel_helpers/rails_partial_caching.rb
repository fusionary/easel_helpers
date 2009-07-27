module ActionView
  module Partials
    private

    def render_partial_with_easel(*args)
      path = args.first[:partial]
      locals = args.last || {}

      easel_cached_column_counts = session[:easel_cached_column_counts] ||= {}

      if easel_cached_column_counts.keys.include?(path)
        @_easel_column_count = locals[:easel_width] || easel_cached_column_counts[path]
        easel_cached_column_counts[path] = @_easel_column_count
      else
        if @_easel_column_count.is_a?(Fixnum) && path !~ /^layout/
          easel_cached_column_counts[path] = @_easel_column_count
        end
      end

      render_partial_without_easel(*args)
    end

    alias_method_chain :render_partial, :easel
  end
end

module EaselHelpers
  module PartialCaching
    def self.included(base)
      base.send :include, EaselHelpers::PartialCaching::InstanceMethods
      base.before_filter :clear_easel_cache
    end

    module InstanceMethods
      def clear_easel_cache
        session[:easel_cached_column_counts] = nil unless request.xhr?
      end
    end
  end
end
