require 'rubygems'
module SupportForm
  class UninstallGenerator < Rails::Generators::Base
    desc "Create thee encessary models and controllers for the application"

    DIRS = ["app/views/support_stats/"]

    FILES = ["app/views/support_stats/",
      "app/models/support_stat.rb",
      "app/controllers/support_stats_controller.rb",
      "app/helpers/support_stats_helper.rb",
      "spec/controllers/support_stats_controller_spec.rb"
    ]
    def run_scaffold_generator
      # create_file "config/initializers/initializer.rb", "# Add initialization content here"

      DIRS.each { |dir| remove_dir(dir)}
      FILES.each { |file| remove_file(file)}

      # Needs much more work
      gsub_file "config/routes.rb", /^.*support_stat.*(\r?\n)?$/, ""
    end
  end
end