require 'active_record/migration'

module ArCheckedMigration
  class Status < Struct.new(:migrations_paths, :migrations_table)

    def all
      return all_down unless Migrations.table_exists?(migrations_table)

      files.each_with_object({}) do |m, h|
        h[m] = migrated.include?(m) ? :up : :down
      end
    end

    def down
      all.select{|migration,status| status == :down }.keys
    end

  private

    def files
      @files ||= Migrations.files(migrations_paths)
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

    def self.files(paths)
      ActiveRecord::Migrator.migrations(paths).map(&:version)
    end
  end
end
