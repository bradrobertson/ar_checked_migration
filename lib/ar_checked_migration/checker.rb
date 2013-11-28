require 'active_support/inflector/methods'

module ArCheckedMigration
  class Checker < Struct.new(:status)
    def safe?
      status.down.all? do |migration|
        require migration.filename
        klass = migration.name.constantize

        klass.respond_to?(:is_safe) && klass.is_safe
      end
    end
  end
end
