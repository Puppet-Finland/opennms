#
# == Class: opennms
#
# Install and configure OpenNMS, a network monitoring system
#
class opennms
(
    $db_password,
    $db_admin_password,
    $snmpv3_security_name,
    $snmpv3_auth_passphrase,
    $snmpv3_auth_protocol,
    $db_user = 'opennms',
    $listen = '127.0.0.1',
    $java_heap_size = '4096',
    $db_name = 'opennms',
    $start_timeout = '120',
    $java_heap_size = '4096',
)
{

    include ::stdlib

    anchor { 'opennms::begin':
        notify => Class['opennms::service'],
    }

    class { '::opennms::prequisites':
        require => Anchor['opennms::begin'],
        notify  => Class['opennms::repos'],
    }
  
    class { '::opennms::repos':
        require => Class['opennms::prequisites'],
        notify  => Class['opennms::install'],
    }
  
    class { '::opennms::install':
        require => Class['opennms::repos'],
        notify  => Class['opennms::config::common'],
    }
    
    class { '::opennms::config::common':
        listen         => $listen,
        java_heap_size => $java_heap_size,
        start_timeout  => $start_timeout,
        require        => Class['opennms::install'],
        notify         => Class['opennms::config::adusers'],
    }

    class {  '::opennms::config::adusers':
        require => Class['opennms::config::common'],
        notify  => Class['opennms::config::syslog'],
    }

    class {  '::opennms::config::syslog':
        require => Class['opennms::config::adusers'],
        notify  => Class['opennms::service'],
    }

    class {  '::opennms::service':
        require => Class['opennms::config::syslog'],
        notify  => Anchor['opennms::end'],
    }
    anchor {'opennms::end': }
}
