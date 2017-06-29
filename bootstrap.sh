#!/bin/bash

# Where are we running from
readonly PROGNAME=$(basename "$0")
readonly PROGDIR=$(dirname "$(readlink -f "$0")")

if egrep -q -i "redhat|centos" /etc/os-release; then
    DIST="RedHat"
    yum install -y redhat-lsb
elif grep -q -i "debian" /etc/os-release ; then
    DIST="Ubuntu"
    apt install -y lsb-release
else
    DIST="Unknown"
fi

# Install puppet from puppetlabs
case "$DIST" in
    Ubuntu)
        if ! dpkg -l|grep -q puppetlabs-release-pc1; then
            wget -P /tmp https://apt.puppetlabs.com/puppetlabs-release-pc1-"$(lsb_release -sc)".deb
            dpkg -i /tmp/puppetlabs-release-pc1-"$(lsb_release -sc)".deb
            apt update
        fi
        dpkg -l|grep -q puppet-agent ||apt install -y puppet-agent
        ;;
    CentOS|RedHat)
        if ! yum list installed |grep -q puppetlabs-release-pc1; then
            rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-"$(lsb_release -sr|cut -d'.' -f1)".noarch.rpm
        fi
        yum list installed |grep -q puppet-agent || yum install -y puppet-agent
        ;;
    *)
        echo "$(lsb_release -si) is not supported."
        exit 1
        ;;
esac

/opt/puppetlabs/bin/puppet module install theforeman/puppet
/opt/puppetlabs/bin/puppet apply "$PROGDIR"/agent.pp
/opt/puppetlabs/bin/puppet module uninstall theforeman/puppet

exit 0
