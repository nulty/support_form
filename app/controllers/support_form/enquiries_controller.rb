module SupportForm
  class EnquiriesController < ApplicationController

    def create
      @enquiry = SupportForm::Enquiry.new(params[:support_form_enquiry])

      topic = params[:support_form_enquiry][:topic]
      @stat = SupportForm::Stat.find(@enquiry.stats_id)

      increment = @stat.stats[topic].to_i.next
      @stat.stats[topic] = increment
      @stat.save
      respond_to do |format|
        format.html {redirect_to(root_path)}
      end
    end
  end
end