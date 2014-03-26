module SupportForm
  class EnquiriesController < ApplicationController

    def new
      if defined?(current_user) && current_user.present?
        full_name = [current_user.first_name, current_user.last_name].join(" ") || ""
        email      = current_user.email || ""
      end
      @enquiry = SupportForm::Enquiry.new(name: full_name, email: email)
    end

    def create
      @enquiry = SupportForm::Enquiry.new(params[:support_form_enquiry])

      topic = @enquiry.topic
      title = params[:support_form_enquiry][:event].presence || "Support enquiry notifier"
      @support_stats = @enquiry.stats
      @support_stats.categories[topic] = @support_stats.categories[topic].to_i.next

      # spam handler
      if params[:support_form_enquiry][:first_name].blank?
        if (@result = @enquiry.valid? && @support_stats.save)
          flash.now[:notice] = "Your support query has been received"
          SupportForm::SupportMailer.support_enquiry_notifier(@enquiry, title).deliver
        end
      end

      flash.now[:notice] = "Your support query has been received"
    end
  end
end