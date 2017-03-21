#!/bin/bash

# Install puppet from puppetlabs
case $(lsb_release -si) in
    Ubuntu)
        apt list --installed 2>/dev/null |grep -q uib-puppetnode && apt-get purge uib-puppetnode
        wget -P /tmp https://apt.puppetlabs.com/puppetlabs-release-pc1-$(lsb_release -sc).deb
        dpkg -i /tmp/puppetlabs-release-pc1-$(lsb_release -sc).deb
        apt update
        apt install puppet-agent
        ;;
    CentOS|RedHat)
        yum list installed |grep -q uib-puppetnode && yum erase uib-puppetnode
        rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-$(lsb_release -sr|cut -d'.' -f1).noarch.rpm
        yum install puppet-agent
        ;;
    *)
        echo "$(lsb_release -si) is not supported."
        exit 1
        ;;
esac

#mkdir -p /root/bootstrap/modules
#puppet module install --modulepath=/root/bootstrap/modules puppetlabs/puppet_agent

puppet agent -t --server client-dev.puppet.uib.no --waitforcert 60 --masterport 8140 --report true

exit 0
