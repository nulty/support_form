module SupportForm
  module Enquiries
    module FormHelper

      def support_form
        @support_stats = SupportForm::Stat.find(get_stats_id)
        enquiry = SupportForm::Enquiry.new(stats_id: @support_stats.id)
        render partial: 'support_form/enquiries/form', locals: {enquiry: enquiry}
      end

      def show_errors(field_name)
        if flash[:errors]
          flash[:errors].grep(Regexp.new(field_name.to_s, true)).first
        end
      end

      def set_field(field_name)
        if flash[:fields] && flash[:fields].has_key?(field_name)
          flash[:fields][field_name.to_sym]
        end
      end

     private
      def get_stats_id
        if defined?(current_item) && current_item.support_stats.present?
          current_item.support_stats.id
        elsif SupportForm::Stat.any?
          SupportForm::Stat.last.id
        else
          raise AssociationNotFoundError, "There is no Stats model for this item!"
        end
      end
    end
  end
end