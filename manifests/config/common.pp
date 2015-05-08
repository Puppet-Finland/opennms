#
# == Class: opennms::config::common
#
# Configure OpenNMS
#
class opennms::config::common
(
  $start_timeout,
  $java_heap_size,
  $listen
  
) inherits opennms::params {

    file { 'opennms-opennms.conf':
        ensure  => present,
        name    => $::opennms::params::config_name,
        content => template('opennms/opennms.conf.erb'),
        owner   => root,
        mode    => '0660',
        require => Class['opennms::install'],
        notify  => Class['opennms::service'],
    }

    file { 'opennms-opennms.properties':
        ensure  => present,
        name    => $::opennms::params::properties_name,
        content => template('opennms/opennms.properties.erb'),
        owner   => root,
        mode    => '0660',
        require => Class['opennms::install'],
        notify  => Class['opennms::service'],
    }

    file { 'opennms-opennms-datasources.xml':
        ensure  => present,
        name    => $::opennms::params::datasources_name,
        content => template('opennms/opennms-datasources.xml.erb'),
        owner   => root,
        mode    => '0660',
        require => Class['opennms::install'],
        notify  => Class['opennms::service'],
    }

    file { 'opennms-snmp-config.xml':
        ensure  => present,
        name    => $::opennms::params::snmpconfig_name,
        content => template('opennms/snmp-config.xml.erb'),
        owner   => root,
        mode    => '0660',
        require => Class[ 'opennms::install' ],
        notify  => Class[ 'opennms::service' ],
    }

    exec { 'setup-java':
        command => '/opt/opennms/bin/runjava -s',
        unless  => '/opt/opennms/bin/runjava -c',
        require => File['opennms-opennms-datasources.xml'],
    }

    exec { 'setup-database':
        command => '/opt/opennms/bin/install -dis',
        onlyif  => '/usr/bin/test ! -f /opt/opennms/etc/configured',
        require => Exec['setup-java'],
    }
}
