module SupportForm
  class EnquiriesController < ApplicationController

    def new
      @enquiry = SupportForm::Enquiry.new
    end

    def create
      # spam handler
      if params[:support_form_enquiry][:first_name].present?
        flash[:notice] = "Your support query has been received"
        if request.referrer.present?
          return redirect_to(:back)
        else
          return redirect_to(root_path)
        end
      end

      @enquiry = SupportForm::Enquiry.new(params[:support_form_enquiry])

      topic = @enquiry.topic
      title = params[:support_form_enquiry][:event].presence || "Support enquiry notifier"
      @stat = SupportForm::Stat.find(@enquiry.stats_id)

      @stat.categories[topic] = @stat.categories[topic].to_i.next

      if @enquiry.valid? && @stat.save
        SupportForm::SupportMailer.support_enquiry_notifier(@enquiry, title).deliver
        flash[:notice] = "Your support query has been received"
        redirect_to(:back) rescue redirect_to(root_path)
      else
        set_the_errors
        if request.referrer.present?
          redirect_to(:back)
        else
          render action: 'new', enquiry: @enquiry
        end
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