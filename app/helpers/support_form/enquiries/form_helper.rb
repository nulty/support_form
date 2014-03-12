module SupportForm
  module Enquiries
    module FormHelper

      def support_form
        @support_stats = SupportForm::Stat.find(get_stats_id)
        enquiry = SupportForm::Enquiry.new(stats_id: @support_stats.id)
        render partial: 'support_form/enquiries/form', locals: {enquiry: enquiry}
      end

      def display_flash
        flash[:notice] if SupportForm.configuration.use_form_flash
      end

     private
      def get_stats_id
        if defined?(current_item) && current_item.support_stats.present?
          current_item.support_stats.id
        else
          raise AssociationNotFoundError, "There is no Stats model for this item!"
        end
      end
    end
  end
end