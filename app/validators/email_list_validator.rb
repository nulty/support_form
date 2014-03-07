class EmailListValidator < ActiveModel::Validator

  def validate(record)
    email_format = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    expected_emails = record.recipient_email.count("@")

    unless record.recipient_email.match(email_format)
      record.recipient_email.split(",").map(&:strip).each do |email|
        unless email.match(email_format)
          record.errors.add(:base, "The format of your recipients_emails is invalid")
        end
      end
    end
  end
end
