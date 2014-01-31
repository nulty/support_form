module SupportForm
  class Stat < ActiveRecord::Base
    self.table_name = :support_form_stats

    attr_accessible :stats, :recipient_email

  end
end