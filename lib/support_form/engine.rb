module SupportForm
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework  :rspec
    end

    I18n.enforce_available_locales = false
  end
end
