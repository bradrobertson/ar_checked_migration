module ArCheckedMigration
  class Status < Struct.new(:migrations, :migrations_table)

    def all
      return all_down unless Migrations.table_exists?(migrations_table)

      {down: down_migrations, up: up_migrations}
    end

    def down
      all[:down]
    end

  private

    def versions
      migrations.map(&:version)
    end

    def all_down
      {down: migrations, up: []}
    end

    def up_migrations
      migrations.select{|m| migrated_versions.include?(m.version) }
    end

    def down_migrations
      migrations - up_migrations
    end

    def migrated_versions
      @migrated_versions ||= Migrations.up(migrations_table).map(&:to_i)
    end
  end

  module Migrations
    def self.table_exists?(table)
      ActiveRecord::Base.connection.table_exists?(table)
    end

    def self.up(table)
      ActiveRecord::Base.connection.select_values(<<-SQL
        SELECT version FROM #{table}
      SQL
      )
    end
  end
end
