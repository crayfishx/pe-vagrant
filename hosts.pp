Host {
  target => '/vagrant/hosts.shared'
}


host { "localhost":
  ip => '127.0.0.1',
  host_aliases => [ 'localhost.localdomain' ],
}

host { $::hostname:
  ip => $::ipaddress,
  host_aliases => [ $::fqdn ]
}

file { '/etc/hosts':
  ensure => link,
  target => '/vagrant/hosts.shared',
}

  
