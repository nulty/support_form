class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter { @support_stats = SupportForm::Stat.new}
end
