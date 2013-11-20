module Migrations
  extend self

  # A direct listing of all the migration file timestamps
  def all
    files = Dir["#{SPEC_ROOT}/support/migrations/*.rb"]
    files.map { |file| file.match(timestamp_regex)[1].to_i }
  end

private

  def timestamp_regex
    /(\d{14})_.*\.rb/
  end
end
