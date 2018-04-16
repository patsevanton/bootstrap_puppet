class { 'puppet':
  server         => false,
  server_foreman => false,
  agent          => true,
  runmode        => 'none',
  puppetmaster   => 'puppetserver02.uib.no',
  ca_server      => 'puppetca.uib.no',
}
