# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :minitest do
  watch(%r{^spec/(.*)_spec\.rb})
  watch(%r{^lib/(.+)\.rb})         { |m| "spec/unit/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb})         { |m| "spec/integration/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/spec_helper\.rb}) { 'spec' }
end
