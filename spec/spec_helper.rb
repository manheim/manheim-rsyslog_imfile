require 'rspec-puppet'

spec_dir = File.expand_path(File.join(__FILE__, '..'))
fixture_path = File.expand_path(File.join(spec_dir, 'fixtures'))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
  c.environmentpath = spec_dir
end
