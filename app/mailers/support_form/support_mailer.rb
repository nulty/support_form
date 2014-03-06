class SupportForm::SupportMailer < ActionMailer::Base
  default from: "from@example.com"

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

    mail(to: enquiry.stats['recipient_email'],
         from: @email,
         subject: subject)
  end
end
