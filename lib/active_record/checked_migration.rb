require 'active_record/migration'

module ActiveRecord
  class CheckedMigration < ActiveRecord::Migration

    def self.is_safe(safe = nil)
      @is_safe = false unless defined?(@is_safe)

      safe.nil? ? @is_safe : @is_safe = safe
    end

  end
end