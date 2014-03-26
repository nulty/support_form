module SupportForm
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework  :rspec
    end

    initializer "SupportForm" do |app|
      SupportForm.configuration do |config|
        app.config.assets.precompile += %w( stats_form.js )
      end
    end
  end
end
