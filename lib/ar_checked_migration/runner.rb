require 'ar_checked_migration/status'
require 'ar_checked_migration/checker'

module ArCheckedMigration
  class Runner

    class << self
      attr_writer :migrations, :table_name

      def migrations
        @migrations || raise("You must give an ActiveRecord::MigrationProxy array")
      end

      def table_name
        @table_name || raise("You must specify the schema migrations table_name")
      end

      def safe?
        status  = Status.new(migrations, table_name)
        checker = Checker.new(status)

        checker.safe?
      end
    end
  end
end
