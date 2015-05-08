#
# == Class: opennms::service
#
# Set up opennms service
#
class opennms::service inherits opennms::params {
  
  service { 'opennms':
    ensure => running,
    name   => $::opennms::params::service_name,
    enable => true,
  }
}
