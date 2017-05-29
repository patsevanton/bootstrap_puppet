class { 'puppet':
  server         => true,
  server_foreman => false,
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
