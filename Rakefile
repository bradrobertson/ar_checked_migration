require "bundler/gem_tasks"
require "bundler/setup"

require 'appraisal'

require 'rake/testtask'

Rake::TestTask.new(:spec) do |t|
  t.libs << "lib" << "spec"
  t.test_files = FileList['spec/*_spec.rb']
  t.verbose = true
end