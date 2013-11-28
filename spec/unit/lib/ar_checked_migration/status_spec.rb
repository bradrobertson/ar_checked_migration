require 'spec_helper'
require 'ar_checked_migration/status'

describe ArCheckedMigration::Status do
  let(:migrations_table){ 'schema_migrations' }
  let(:migrations_paths){ ["#{SPEC_ROOT}/support/migrations"] }
  let(:migrations_files){ Migrations.all }
  let(:up){ migrations_files.take(2) }

  let(:status) { ArCheckedMigration::Status.new(migrations_paths, migrations_table) }

  describe "#down" do
    before do
      stub(ArCheckedMigration::Migrations).table_exists?{ true }
      stub(ArCheckedMigration::Migrations).up{ up }
    end

    it "fetches all migrations that haven't been run" do
      status.down.must_equal migrations_files - up
    end
  end
end
