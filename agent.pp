class { 'puppet':
  server         => false,
  server_foreman => false,
  agent          => true,
  puppetmaster   => 'puppetserver01.uib.no',
  ca_server      => 'puppetca.uib.no,'
}

package {'uib-puppetnode':
  ensure => absent,
}

package { 'puppet-common':
  ensure => absent,
}

package { 'puppet':
  ensure => absent,
}
