require 'minitest/autorun'
require 'minitest-spec-context'
require 'minitest/reporters'
require 'rr'

Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new

lib = File.expand_path('../lib', File.dirname(__FILE__))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'active_record'
require 'ar_checked_migration'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

SPEC_ROOT = File.dirname(File.expand_path(__FILE__))

Dir["#{SPEC_ROOT}/support/**/*.rb"].each{|f| require f }
