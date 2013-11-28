require 'spec_helper'

describe ArCheckedMigration::Status do
  let(:migrations_table)      { Migrations.table }
  let(:migrations)            { Migrations.all }
  let(:migrations_timestamps) { Migrations.timestamps }
  let(:up){ migrations.first(2) }

  let(:status) { ArCheckedMigration::Status.new(migrations, migrations_table) }

  describe "#down" do
    before do
      stub(ArCheckedMigration::Migrations).table_exists?{ true }
      stub(ArCheckedMigration::Migrations).up{ up.map(&:version) }
    end

    it "fetches all migrations that haven't been run" do
      status.down.must_equal migrations - up
    end
  end
end
