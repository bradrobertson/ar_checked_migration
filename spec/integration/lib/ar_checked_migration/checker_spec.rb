require 'spec_helper'

describe ArCheckedMigration::Checker do

  let(:table)           { Migrations.table }
  let(:migrated)        { [] }
  let(:migrated_values) { migrated.map{|m| "(#{m})"} }

  let(:status){ ArCheckedMigration::Status.new(Migrations.all, Migrations.table) }
  let(:checker){ ArCheckedMigration::Checker.new(status) }

  before do
    ActiveRecord::Base.connection.create_table(table, id: false){|t| t.string('version')}
    if migrated.length > 0
      ActiveRecord::Base.connection.execute("INSERT INTO #{table} VALUES #{migrated_values.join(',')}")
    end
  end

  after{ ActiveRecord::Base.connection.drop_table(table) }

  context "non checked migration is down" do
    let(:migrated){ [] }

    it "is not safe" do
      checker.safe?.must_equal false
    end
  end

  context "unsafe checked migration is down" do
    let(:migrated){ Migrations.timestamps.take(1) }

    it "is not safe" do
      checker.safe?.must_equal false
    end
  end

  context "only safe checked migrations are down" do
    let(:migrated){ Migrations.timestamps.take(2) }

    it "is safe" do
      checker.safe?.must_equal true
    end
  end

  context "no migrations to run" do
    let(:migrated){ Migrations.timestamps }

    it "is safe" do
      checker.safe?.must_equal true
    end
  end
end
