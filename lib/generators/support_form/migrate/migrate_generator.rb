module SupportForm
  class MigrateGenerator < Rails::Generators::Base
    desc "Move all the migrations to db/migrate"


    include Rails::Generators::Migration

    source_root File.expand_path("../templates", __FILE__)

    # def self.migrations
    #   [
    #     'create_support_stats'
    #   ]
    # end
    MIGRATIONS = [
      'create_support_form_stats'
    ]

    def create_migration_file
      MIGRATIONS.each do |migration_name|
        if self.class.migration_exists?("db/migrate",migration_name)
          say_status("skipped", "Migration #{migration_name}.rb already exists")
        else
          migration_template "#{migration_name}.rb", "db/migrate/#{migration_name}.rb"
        end
      end
    end

    protected

    def self.next_migration_number(dirname)

      if ActiveRecord::Base.timestamped_migrations
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end

  end
end