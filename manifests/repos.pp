#
# == Class: opennms::repos
#
# Use OpenNMS yum repos
#
class opennms::repos {
  
    yumrepo { 'opennms-stable-rhel6':
        baseurl  => 'http://yum.opennms.org/stable/rhel6',
        descr    => 'RedHat Enterprise Linux 6.x and CentOS 6.x (stable)',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => 'http://yum.opennms.org/OPENNMS-GPG-KEY',
    }

    yumrepo { 'opennms-stable-common':
        baseurl  => 'http://yum.opennms.org/stable/common',
        descr    => 'RPMs Common to All OpenNMS Architectures (stable)',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => 'http://yum.opennms.org/OPENNMS-GPG-KEY',
    }
}
