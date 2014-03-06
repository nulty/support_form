module ApplicationHelper

  def current_item
    @page || @stat.supportable
  end
end
