#
# == Class: opennms::config::postgresql
#
# Configure postgresql so that opennms can use it as a data store
#
class opennms::config::postgresql {

    file { '/var/lib/pgsql/data/pg_hba.conf':
        ensure  => present,
        content => template('opennms/pg_hba.conf.erb'),
        owner   => root,
        mode    => '0660',
        require => Class['postgresql::initdb'],
        notify  => Class['postgresql::service'],
    }
}

