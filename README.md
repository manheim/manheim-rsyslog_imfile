# rsyslog_imfile 

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description) - What the module does and why it is useful
3. [Setup](#setup) - The basics of getting started with rsyslog_imfile
  * [What rsyslog_imfile affects](#what-rsyslog_imfile-affects)
  * [Setup Requirements](#setup-requirements)
  * [Beginning with rsyslog_imfile](#beginning-with-rsyslog_imfile)
4. [Usage](#usage) - Configuration options and additional functionality
5. [Reference](#reference) - An under-the-hood peek at what the module is doing and how
6. [Limitations](#limitations) - OS Compatibility, etc.
7. [Development](#development) - Guide for contributing to the module

## Overview

This module configures Rsyslog's [Text File Input Module][imfile].

## Module Description

The rsyslog_imfile module allows you to configure rsyslog's text file input module so that the log files you've always been writing out to can become syslog messages. With this in place, a person writing an application can log where they are used to and the server can be configured to pick up those messages and do any number of things (e.g. parse, filter, ship off the server).

## Setup

### What rsyslog_imfile Affects

* The contents of any conf files in /etc/rsyslog.d/ that you have configured to be created

### Setup Requirements

To be of most use, you should have rsyslog configurations in place.

### Beginning with rsyslog_imfile 

```pupppet
  class { 'rsyslog_imfile':
    logs => {
      'component_error' => {
        'filename' => '/home/myapp/component/logs/error.log',
        'severity' => 'error',
      },
    },
  }
```

## Usage

The only param for configuring the ``rsyslog_imfile`` class is the ``logs`` hash. This hash can be written inline as the example above shows, or it can be set as Hiera data and passed in.

```yaml
---
logs:
  component_error:
    filename: /home/myapp/component/logs/error.log
    severity: error
```

```puppet
  class { 'rsyslog_imfile':
    logs => hiera('logs'),
  }
```

However the hash is created, it should have:

* a __key__ name that is descriptive of the information being logged
* The __filepath__ to the log file
* The __severity__ of the messages contained in the log file

The __key__ will be used as the name of the resulting conf file. Also, it will be the ``InputFileTag`` and as part of the name for the ``InputFileStateFile``. The __filepath__ will be used as the ``InputFileName``. And the __severity__ will be used as the ``InputFileSeverity``.

__/etc/rsyslog.d/component_error.conf__:

```
$ModLoad imfile
$InputFilePollInterval 10

#component_error
$InputFileName /home/myapp/component/logs/component_error.log
$InputFileName /srv/apps/man-probe/current/log/probe.log
$InputFileTag component_error:
$InputFileStateFile stat-component_error-log
$InputFileSeverity error
$InputRunFileMonitor
```

You can define as many log files in the logs hash as you need.

## Reference

### Classes

* ``rsyslog_imfile``: Main class for iterating over the logs hash creating imfile configurations
* ``rsyslog_imfile:logfile``: Handles the creating of the imfile configurations by pasing the log properties to a template and restarting rsyslog

### Parameters

#### `rsyslog_imfile`

- `logs`
  > Hash, each key represents a log file and has a hash value containing properties for the logfile

#### `rsyslog_imfile:logfile`

- `filepath`
  > String, the path to the log file
- `severity`
  > String, the message severity. Must be one of: 'emerg', 'alert', 'crit', 'error', 'warning', 'notice', 'info', 'debug'.

## Limitations

Does not configure rsyslog for you.

## Development

If you would like to contribute, fork this repo then submit a pull request. Please test your changes before submitting a pull request.

Use the provided rake tasks to run the tests:

```shell
> bundle install
> bundle exec rake -T
rake rspec             # Run all RSpec code examples
rake rspec:acceptance  # Run acceptance RSpec code examples
rake rspec:classes     # Run classes RSpec code examples
rake rspec:defines     # Run defines RSpec code examples
rake rspec:functions   # Run functions RSpec code examples
rake rspec:hosts       # Run hosts RSpec code examples
```

The acceptance tests require that you have [Vagrant][vagrantup] installed




[imfile]: http://www.rsyslog.com/doc/v8-stable/configuration/modules/imfile.html "imfile: Text File Input Module &mdash; rsyslog 8.10.0 documentation"
[vagrantup]: https://www.vagrantup.com/downloads.html "Download Vagrant - Vagrant"
