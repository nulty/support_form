require "support_form/engine"
require "support_form/configuration"

module SupportForm
  if ::I18n.respond_to?(:enforce_available_locales=)
    ::I18n.config.enforce_available_locales = true
  end
  self.configure
end
