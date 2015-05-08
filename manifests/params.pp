#
# == Class: opennms::params
#
# Defines some variables based on the operating system
#
class opennms::params {

    case $::osfamily {
        'RedHat': {
            $package_name = [ 'opennms', 'opennms-core', 'iplike' ]
            $service_name = 'opennms'
            $config_name = '/opt/opennms/etc/opennms.conf'
            $properties_name = '/opt/opennms/etc/opennms.properties'
            $datasources_name = '/opt/opennms/etc/opennms-datasources.xml'
            $snmpconfig_name = '/opt/opennms/etc/snmp-config.xml'
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
