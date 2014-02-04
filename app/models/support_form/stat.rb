module SupportForm
  class Stat < ActiveRecord::Base
    self.table_name = :support_form_stats
    serialize :stats, Hash

    attr_accessible :stats, :recipient_email
    attr_accessor :name, :email, :message, :category_name

    validates :stats, :recipient_email, presence: true
  end
end