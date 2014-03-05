module SupportForm
  class Stat < ActiveRecord::Base
    self.table_name = :support_form_stats
    belongs_to :supportable, polymorphic: true

    serialize :categories, Hash

    attr_accessible :categories, :recipient_email
    attr_accessor :category_name_value

    # validates :categories, :recipient_email, presence: true
  end
end