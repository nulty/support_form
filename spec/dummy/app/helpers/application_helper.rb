module ApplicationHelper

  def current_item
    @page || @support_stats.supportable
  end

  def current_user
    if $LOGGEDIN
      User.new(first_name: "Joe", last_name: "Bloggs", email: "joe@email.com")
    end
  end
end
