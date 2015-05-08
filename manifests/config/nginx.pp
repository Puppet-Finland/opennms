#
# == Class: opennms::config::nginx
#
# Basic configuration of Nginx for hosting Opennms. This does not include 
# per-project settings or optional LDAP settings.
#
class opennms::config::nginx {
  
    # We place this file into conf.d as we don't host multiple sites; 
    # all Nginx configuration files are considered global.
    file { 'opennms-opennms-common':
        ensure  => present,
        name    => '/etc/nginx/conf.d/opennms-common',
        content => template('opennms/opennms-common.erb'),
        owner   => root,
        group   => root,
        mode    => '0644',
        require => [ Class['nginx::install'], Class['opennms::config::common'] ],
        notify  => Class['nginx::service'],
    }
}
