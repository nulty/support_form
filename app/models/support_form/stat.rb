require_relative '../../validators/email_list_validator.rb'
module SupportForm
  class Stat < ActiveRecord::Base

    self.table_name = :support_form_stats
    belongs_to :supportable, polymorphic: true

    serialize :categories, Hash

    attr_accessible :categories, :recipient_email, :sender_email
    attr_accessor :category_name_value

    validates :categories, presence: true, allow_blank: true
    validates :sender_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, allow_blank: true
    validates_with EmailListValidator, allow_blank: true
    validates_with CategoryCountValidator#, allow_blank: true
  end
end