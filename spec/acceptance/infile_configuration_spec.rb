require 'spec_helper_acceptance'

describe 'rsyslog_imfile' do
  it 'should create config file in /etc/rsyslog.d/' do
    name     = "error_log"
    filepath = "error.log"
    severity = "error"
    pp       = %Q{
class { 'rsyslog_imfile':
  logs    => {
    "#{name}" => { 
      "filepath" => "#{filepath}",
      "severity" => "#{severity}",
    },
  },
}
    }

    expected_output = %Q{$ModLoad imfile
$InputFilePollInterval 10

##{name}
$InputFileName #{filepath}
$InputFileTag #{name}:
$InputFileStateFile stat-#{name}-log
$InputFileSeverity #{severity}
$InputRunFileMonitor}

    apply_manifest(pp, :catch_failures => true)
    actual_output = shell("cat /etc/rsyslog.d/#{name}.conf").stdout
    expect(actual_output.strip).to eq(expected_output.strip)
  end
end
