class SupportForm::SupportMailer < ActionMailer::Base
  default from: "no-reply@picturk.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_form.support_mailer.support_enquiry_notifier.subject
  #
  def support_enquiry_notifier(enquiry, title)
    @title   = title
    @name    = enquiry.name
    @email   = enquiry.email
    @message = enquiry.message
    @topic   = enquiry.topic
    subject  = "#{@name} - #{@topic} - #{@title}"

    @stats = enquiry.stats['categories']


    mail_hash = {to: enquiry.stats['recipient_email'],
                 subject: subject}

    if enquiry.stats.sender_email.present?
      mail_hash.merge!({from: enquiry.stats.sender_email})
    end

    mail(mail_hash)
  end
end
