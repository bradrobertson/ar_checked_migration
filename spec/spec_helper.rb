require 'minitest/autorun'
require 'minitest-spec-context'

lib = File.expand_path('../lib', File.dirname(__FILE__))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'active_record'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"