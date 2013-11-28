require 'spec_helper'
require 'ar_checked_migration/status'

describe ArCheckedMigration::Status do
  let(:migrations_table){ 'schema_migrations' }
  let(:migrations_paths){ ["#{SPEC_ROOT}/support/migrations"] }
  let(:migrations_files){ Migrations.all }

  let(:status) { ArCheckedMigration::Status.new(migrations_paths, migrations_table) }

  describe '#all' do
    context "no migrations table exists" do
      it "considers all migrations down" do
        expected = migrations_files.each_with_object({}){|m, h| h[m] = :down }
        status.all.must_equal expected
      end
    end

    context "migrations table exists" do
      before{ ActiveRecord::Base.connection.create_table(migrations_table, id: false){|t| t.string('version')} }
      after{ ActiveRecord::Base.connection.drop_table(migrations_table) }

      it "also considers all things down" do
        expected = migrations_files.each_with_object({}){|m, h| h[m] = :down }
        status.all.must_equal expected
      end

      context "with some migrations up" do
        let(:up_count){ 2 }
        let(:migrated){ migrations_files.take(up_count).map{|f| "(#{f})"} }
        before{ ActiveRecord::Base.connection.execute("INSERT INTO #{migrations_table} VALUES #{migrated.join(',')}")}
        after{ ActiveRecord::Base.connection.execute("DELETE FROM #{migrations_table}") }

        it "has some up and some down" do
          expected = {}
          migrations_files.each_with_index do |m,i|
            expected[m] = (i < up_count ? :up : :down)
          end
          status.all.must_equal expected
        end
      end
    end
  end
end
