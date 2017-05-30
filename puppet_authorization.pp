# puppet module install puppetlabs/puppet_authorization
puppet_authorization {'/etc/puppetlabs/puppetserver/conf.d/auth.conf':
  version                => 1,
  allow_header_cert_info => false,
}

#puppet_authorization::rule { 'certificate_delete':
#  match_request_path   => '^/puppet-ca/v1/certificate_status/([^/]+)$',
#  match_request_type   => 'regex',
#  match_request_method => 'delete'
#  allow                => 'restapi.klientdrift.uib.no',
#  sort_order           => 500,
#  path                 => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
#}


puppet_authorization::rule { 'catalog_request':
  match_request_path   => '^/puppet/v3/catalog/([^/]+)$',
  match_request_type   => 'regex',
  match_request_method => ['get', 'post'],
  allow                => '$1',
  sort_order           => 500,
  path                 => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
}

puppet_authorization::rule { 'cert_request':
  match_request_path    => '/puppet-ca/v1/certificate/',
  match_request_type    => 'path',
  match_request_method  => 'get',
  allow_unauthenticated => true,
  sort_order            => 500,
  path                  => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
}

puppet_authorization::rule { 'crl_request':
  match_request_path    => '/puppet-ca/v1/certificate_revocation_list/ca',
  match_request_type    => 'path',
  match_request_method  => 'get',
  allow_unauthenticated => true,
  sort_order            => 500,
  path                  => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
}

puppet_authorization::rule { 'csr_request':
  match_request_path    => '/puppet-ca/v1/certificate_request',
  match_request_type    => 'path',
  match_request_method  => ['get', 'put'],
  allow_unauthenticated => true,
  sort_order            => 500,
  path                  => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
}

puppet_authorization::rule { 'environment_request':
  match_request_path   => '/puppet/v3/environments',
  match_request_type   => 'path',
  match_request_method => 'get',
  allow                => '*',
  sort_order           => 500,
  path                 => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
}

puppet_authorization::rule { 'resource type':
  match_request_path   => '/puppet/v3/resource_type',
  match_request_type   => 'path',
  match_request_method => ['get', 'post'],
  allow                => '*',
  sort_order           => 500,
  path                 => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
}

puppet_authorization::rule { 'file_request':
  match_request_path => '/puppet/v3/file',
  match_request_type => 'path',
  allow              => '*',
  sort_order         => 500,
  path               => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
}

puppet_authorization::rule { 'node_definition_request':
  match_request_path   => '^/puppet/v3/node/([^/]+)$',
  match_request_type   => 'regex',
  match_request_method => 'get',
  allow                => '$',
  sort_order           => 500,
  path                 => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
}

puppet_authorization::rule { 'reports':
  match_request_path   => '^/puppet/v3/report/([^/]+)$',
  match_request_type   => 'regex',
  match_request_method => 'put',
  allow                => '$1',
  sort_order           => 500,
  path                 => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
}

puppet_authorization::rule { 'status_request':
  match_request_path    => '/puppet/v3/status',
  match_request_type    => 'path',
  match_request_method  => 'get',
  allow_unauthenticated => true,
  sort_order            => 500,
  path                  => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
}

puppet_authorization::rule { 'static_file_content':
  match_request_path   => '/puppet/v3/static_file_content',
  match_request_type   => 'path',
  match_request_method => 'get',
  allow                => '*',
  sort_order           => 500,
  path                 => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
}

puppet_authorization::rule { 'deny_everything_else':
  match_request_path => '/',
  match_request_type => 'path',
  deny               => '*',
  sort_order         => 999,
  path               => '/etc/puppetlabs/puppetserver/conf.d/auth.conf',
}
