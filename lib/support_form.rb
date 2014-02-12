require "support_form/engine"

module SupportForm
  if ::I18n.respond_to?(:enforce_available_locales=)
    ::I18n.config.enforce_available_locales = true
  end
end
