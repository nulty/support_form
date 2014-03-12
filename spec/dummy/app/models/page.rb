class Page < ActiveRecord::Base
  # attr_accessible :title, :body

  has_one :support_stats, as: :supportable, class_name: "SupportForm::Stat"

  def title
    "Title"
  end

  def theme
    o = Object.new
    o.define_singleton_method(:title) { "Title" }
    {:public=>o}
  end
end
