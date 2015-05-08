# OpenNMS

A Puppet module for managing OpenNMS. This module is still work in progress (see 
TODO, below).

# Module usage

* [Class: OpenNMS](manifests/init.pp)

# Dependencies

See [metadata.json](metadata.json).

# Operating system support

This module has been tested on

* Centos 6

For details see [params.pp](manifests/params.pp).

# TODO

* Add Active Directory integration
* Remove generic postgresql configurations
* Start using pg_hba provider from https://github.com/hercules-team
* Add SNMP range configuration
* Improve OS-independence
