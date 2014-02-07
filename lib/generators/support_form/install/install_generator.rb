require 'rubygems'
module SupportForm
  class InstallGenerator < Rails::Generators::Base
    desc "Create thee encessary models and controllers for the application"

    def run_scaffold_generator
      # create_file "config/initializers/initializer.rb", "# Add initialization content here"
      inject_into_file "app/helpers/application_helper.rb", after: "module ApplicationHelper\n" do <<-'RUBY'
  include SupportForm::Enquiries::FormHelper
      RUBY
      end
    end
  end
end