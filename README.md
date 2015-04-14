# sonar_loggly

For configuring Loggly the Sonar way.

Usage:

_sonar.yaml_

```yaml
---
logpath: /home/sonar/component/logs
logs:
  component_warn:
    filename: sonar-warn.log
    seveity: warn
  component_info:
    filename: sonar-info.log
    severity: info
  component_error:
    filename: sonar-error.log
    severity: error
```

_site.pp_

```puppet
  class { 'sonar_loggly': 
    logpath => hiera('logpath'),
    logs    => hiera('logs'),
  }
```
