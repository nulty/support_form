require 'generators/support_form'
require 'rubygems'
module SupportForm
  module Generators
    class InstallGenerator < Base
      desc "Create the necessary models and controllers for the application"

      # source_root File.expand_path("../templates", __FILE__)
      def run_scaffold_generator
        # create_file "config/initializers/initializer.rb", "# Add initialization content here"

        inject_into_file "app/helpers/application_helper.rb", after: "module ApplicationHelper\n" do <<-'RUBY'
  include SupportForm::Enquiries::FormHelper
        RUBY
        end
      end
      invoke "support_form:migrate"
    end
  end
end