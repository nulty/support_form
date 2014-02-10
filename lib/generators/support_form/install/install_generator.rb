require 'generators/support_form'

module SupportForm
  module Generators
    class InstallGenerator < Base
      desc "Global install for support_form"

      def install_support_form
        # create_file "config/initializers/initializer.rb", "# Add initialization content here"
      end
      invoke "support_form:migrate"
    end
  end
end