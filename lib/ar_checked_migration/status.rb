require 'active_record/migration'

module ArCheckedMigration
  class Status < Struct.new(:migrations_paths, :migrations_table)

    def all
      return all_down unless Migrations.table_exists?(migrations_table)

      files.each_with_object({}) do |m, h|
        h[m] = migrated.include?(m) ? :up : :down
      end
    end

  private

    def files
      @files ||= ActiveRecord::Migrator.migrations(migrations_paths).map(&:version)
    end

    def all_down
      files.each_with_object({}){|m,h| h[m]=:down}
    end

    def migrated
      @migrated ||= Migrations.up(migrations_table).map(&:to_i)
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
