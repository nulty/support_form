module SupportForm
  module FormHelper
    def support_form
      @support_stats = SupportForm::Stat.new
      render 'support_form/stats/form'
    end
  end
end