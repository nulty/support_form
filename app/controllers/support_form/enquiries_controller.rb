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
      respond_to do |format|
        if (@result = @enquiry.valid? && @stat.save)
          set_the_errors
          title =  "Support enquiry notifier"
          SupportForm::SupportMailer.support_enquiry_notifier(@enquiry, title).deliver
          flash[:notice] = "Your support query has been received"
          format.js   { flash.now[:notice] = "Your support query has been received" }
          format.html { redirect_to(:back) rescue redirect_to(root_path) }
        else
          set_the_errors
          if request.referrer.present?
            format.js
            format.html { redirect_to(:back) }
          else
            format.js
            format.html { render action: 'new', enquiry: @enquiry }
          end
        end
      end
    end

private
    def set_the_errors
      flash.now[:errors] = @enquiry.errors.full_messages
      flash.now[:fields] = {}

      flash.now[:fields][:topic] = @enquiry.topic if @enquiry.topic.present?
      flash.now[:fields][:name] = @enquiry.name if @enquiry.name.present?
      flash.now[:fields][:email] = @enquiry.email if @enquiry.email.present?
      flash.now[:fields][:message] = @enquiry.message if @enquiry.message.present?
    end
  end
end