require 'spec_helper'
require 'activerecord/checked_migration'

describe ActiveRecord::CheckedMigration do
  SomeMigration = Class.new(ActiveRecord::CheckedMigration)

  describe "::is_safe" do
    it "defaults to false" do
      SomeMigration.is_safe.must_equal false
    end

    it "allows setting/getting" do
      SomeMigration.is_safe(true)
      SomeMigration.is_safe.must_equal true
      SomeMigration.is_safe(false)
      SomeMigration.is_safe.must_equal false
    end
  end
end