define rsyslog_imfile::logfile (
  $filepath = undef,
  $severity = undef,
) {

  exec { 'restart_rsyslogd':
    command     => 'service rsyslog restart',
    path        => [ '/usr/sbin', '/sbin', '/usr/bin/', '/bin', ],
    refreshonly => true,
  }

  file { "/etc/rsyslog.d/${name}.conf":
    content => template("${module_name}/log.conf.erb"),
    notify  => Exec['restart_rsyslogd'],
  }

}
