module SupportForm
  class InitializerGenerator < Rails::Generators::Base
    desc "Move all new migrations from the support_form gem into the target application"

    def create_initializer_file
      create_file "config/initializers/support_form.rb" do
        %Q^
SupportForm.configure do |config|

  # Set this to true if you don't have flash notices enabled in your application
  config.use_form_flash = false
end
^
      end
    end
  end
end