class Page < ActiveRecord::Base
  # attr_accessible :title, :body

  has_one :support_stats, as: :supportable, class_name: "SupportForm::Stat"

  def title
    "Title"
  end
end
