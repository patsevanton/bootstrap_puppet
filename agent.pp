class { 'puppet':
  server         => false,
  server_foreman => false,
  agent          => true,
  puppetmaster   => 'client-dev.puppet.uib.no',
}

package {'uib-puppetnode':
  ensure => absent,
}
