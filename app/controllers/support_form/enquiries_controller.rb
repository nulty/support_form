module SupportForm
  class EnquiriesController < ApplicationController

    def create
      @enquiry = SupportForm::Enquiry.new(params[:support_form_enquiry])

      topic = @enquiry.topic
      @stat = SupportForm::Stat.find(@enquiry.stats_id)

      @stat.stats[topic] = @stat.stats[topic].to_i.next

      if @enquiry.valid? && @stat.save
        redirect_to(root_path)
      else
        set_the_errors
        redirect_to(:back)
      end
    end

private
    def set_the_errors
      flash[:errors] = @enquiry.errors.full_messages
      flash[:fields] = {}

      flash[:fields][:topic] = @enquiry.topic if @enquiry.topic.present?
      flash[:fields][:name] = @enquiry.name if @enquiry.name.present?
      flash[:fields][:email] = @enquiry.email if @enquiry.email.present?
      flash[:fields][:message] = @enquiry.message if @enquiry.message.present?
    end
  end
end