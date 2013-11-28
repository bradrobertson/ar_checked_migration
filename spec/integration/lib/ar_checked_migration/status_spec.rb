require 'spec_helper'

describe ArCheckedMigration::Status do
  let(:migrations_table)     { Migrations.table }
  let(:migrations)           { Migrations.all }
  let(:migrations_timestamps){ Migrations.timestamps }

  let(:status) { ArCheckedMigration::Status.new(migrations, migrations_table) }

  describe '#all' do
    context "no migrations table exists" do
      it "considers all migrations down" do
        status.all.must_equal(down: migrations, up: [])
      end
    end

    context "migrations table exists" do
      before{ ActiveRecord::Base.connection.create_table(migrations_table, id: false){|t| t.string('version')} }
      after{ ActiveRecord::Base.connection.drop_table(migrations_table) }

      it "also considers all things down" do
        status.all.must_equal(down: migrations, up: [])
      end

      context "with some migrations up" do
        let(:up_count){ 2 }
        let(:migrated){ migrations_timestamps.first(up_count).map{|f| "(#{f})"} }
        before{ ActiveRecord::Base.connection.execute("INSERT INTO #{migrations_table} VALUES #{migrated.join(',')}")}

        it "has some up and some down" do
          status.all.must_equal(
            up: migrations.first(2),
            down: migrations.last(2)
          )
        end
      end
    end
  end
end
