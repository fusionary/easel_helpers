require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_support/test_case'

require 'shoulda/rails'
require 'action_controller'
require 'action_controller/test_process'

require "easel_helpers"

ActionView::Base.send :include, EaselHelpers::Helpers
ActionController::Base.send :include, EaselHelpers::PartialCaching

class EaselHelpers::ViewTestCase < ActiveSupport::TestCase
  include ActionController::Assertions::SelectorAssertions

  def setup
    super
    @view = ActionView::Base.new
  end

  protected

  def show_view(template)
    @html_result = ActionView::InlineTemplate.new(template).render(@view, {})
    @html_document = HTML::Document.new(@html_result, true, false)
    yield if block_given?
  end

  def response_from_page_or_rjs
    @html_document.root
  end
end
