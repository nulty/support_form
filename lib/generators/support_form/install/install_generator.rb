require 'generators/support_form'

module SupportForm
  module Generators
    class InstallGenerator < Base
      desc "Global install for support_form"

      invoke "support_form:initializer"
      invoke "support_form:migrate"
    end
  end
end