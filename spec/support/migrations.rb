module Migrations
  extend self

  def all
    ActiveRecord::Migrator.migrations(["#{SPEC_ROOT}/support/migrations"])
  end

  def timestamps
    all.map(&:version)
  end

private

  def timestamp_regex
    /(\d{14})_.*\.rb/
  end
end
