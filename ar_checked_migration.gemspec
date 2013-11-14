# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ar_checked_migration/version'

Gem::Specification.new do |spec|
  spec.name          = "ar_checked_migration"
  spec.version       = ArCheckedMigration::VERSION
  spec.authors       = ["Brad Robertson"]
  spec.email         = ["bradleyrobertson@gmail.com"]
  spec.description   = %q{Determine whether or not ActiveRecord migrations are
                         considered safe to know if an app
                         needs to go into maintenance on deploy}
  spec.summary       = %q{Check 'safe' and 'unsafe' migrations}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rails"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "sqlite3"

  spec.add_runtime_dependency "activerecord", ">= 3.2"
end
