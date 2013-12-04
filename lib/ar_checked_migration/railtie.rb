require 'ar_checked_migration/runner'

module ArCheckedMigration
  class Railtie < Rails::Railtie

    initializer 'ar_checked_migration.init' do
      ActiveSupport.on_load(:active_record) do
        migrations = ActiveRecord::Migrator.migrations(ActiveRecord::Migrator.migrations_paths)
        table_name = ActiveRecord::Migrator.schema_migrations_table_name

        ArCheckedMigration::Runner.migrations = migrations
        ArCheckedMigration::Runner.table_name = table_name
      end
    end

    config.app_generators do |g|
      g.templates.unshift File.expand_path('../templates', __FILE__)
    end
  end
end
