require "hpricot"
require "easel_helpers"

ActionView::Base.send :include, EaselHelpers::Helpers
ActionController::Base.send :include, EaselHelpers::PartialCaching