module SupportForm
  module Enquiries
    module FormHelper

      def support_form
        modal = @_request.env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest" ? true : false
        render partial: 'support_form/enquiries/form', locals: {enquiry: the_enquiry, modal: modal}
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

      def display_flash
        if SupportForm.configuration.use_form_flash
          content_tag :div, flash[:notice], class: "flash-notice"
        end
      end

      def support_modal
        render partial: 'support_form/enquiries/modal_form', locals: {enquiry: the_enquiry}
      end

      def the_enquiry
        @support_stats = SupportForm::Stat.find(get_stats_id)
        SupportForm::Enquiry.new(stats_id: @support_stats.id)
      end

      def current_item_title
        if defined?(current_item) && current_item.respond_to?(:theme)
          current_item.theme.first.last.title
        else
          current_item.title
        end
      end

      def submit_button(f, local_assigns=false)
        result =  ['Request Support', {id: "support-submit", class: "btn btn-primary", data: {disable_with: "Working..."}}]
        if local_assigns && (local_assigns[:locals] && local_assigns[:locals][:modal]) || local_assigns[:modal]
          result.last.merge!({style: "display:none"})
        end
        f.submit(*result)
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