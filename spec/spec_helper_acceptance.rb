require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

hosts.each do |host|
  install_puppet
end

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  ignore = ['junit', 'log', 'Gemfile', 'Gemfile.lock', 'README.md', 'metadata.json']

  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      copy_module_to(host, { :source => proj_root,
                             :module_name => 'rsyslog_imfile',
                             :ignore_list => ignore })
    end
  end
end
