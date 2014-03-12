module SupportForm
  class EnquiriesController < ApplicationController

    def new
      @enquiry = SupportForm::Enquiry.new
    end

    def create
      @enquiry = SupportForm::Enquiry.new(params[:support_form_enquiry])

      topic = @enquiry.topic
      title = params[:support_form_enquiry][:event].presence || "Support enquiry notifier"
      @support_stats = @enquiry.stats
      @support_stats.categories[topic] = @support_stats.categories[topic].to_i.next

      # spam handler
      if params[:support_form_enquiry][:first_name].present?
        flash.now[:notice] = "Your support query has been received"
        return render :create, handlers: [:js]
      else
        if (@result = @enquiry.valid? && @support_stats.save)
          flash.now[:notice] = "Your support query has been received"
          SupportForm::SupportMailer.support_enquiry_notifier(@enquiry, title).deliver

          respond_to do |format|
            format.js do
              flash.now[:notice] = "Your support query has been received"
            end
          end
        end
      end

    end
  end
end