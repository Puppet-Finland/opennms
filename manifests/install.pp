#
# == Class: opennms::install
#
# Install Opennms using easy_install. By default Opennms will go to /usr/local.
#
class opennms::install inherits opennms::params {

    package { 'opennms-opennms':
        ensure => installed,
        name   => $::opennms::params::package_name,
    }
}
