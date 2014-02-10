module SupportForm
  class Stat < ActiveRecord::Base
    self.table_name = :support_form_stats
    belongs_to :supportable, polymorphic: true

    serialize :stats, Hash

    attr_accessible :stats, :recipient_email
    attr_accessor :category_name, :category_name_value

    validates :stats, :recipient_email, presence: true
  end
end