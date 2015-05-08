#
# == Class: opennms::prequisites
#
# Setup various Opennms's prequisites. 
#
class opennms::prequisites {

    anchor { 'opennms::prequisites:begin':
        notify => Service['postgresql'],
    }

    package { 'postgresql-server':
        ensure  => installed,
        require => Anchor['opennms::prequisites:begin'],
        notify  => Exec['initdb'],
    }

    exec { 'initdb':
        command => '/sbin/service postgresql initdb',
        unless  => '/usr/bin/test -d /var/lib/pgsql/data',
        require => Package['postgresql-server'],
        notify  => File['/var/lib/pgsql/data/pg_hba.conf'],
    }

    file { '/var/lib/pgsql/data/pg_hba.conf':
        ensure  => present,
        content => template('opennms/pg_hba.conf.erb'),
        owner   => root,
        mode    => '0660',
        require => Exec['initdb'],
        notify  => Service['postgresql'],
    }

    service { 'postgresql':
        ensure  => running,
        enable  => true,
        require => File['/var/lib/pgsql/data/pg_hba.conf'],
        notify  => Anchor['opennms::prequisites::end'],
    }

    anchor {'opennms::prequisites::end': }
}
