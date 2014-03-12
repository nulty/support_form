module ApplicationHelper

  def current_item
    @page || @support_stats.supportable
  end
end
