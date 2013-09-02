# general packages & services

exec { "update":
    command => '/usr/bin/apt-get update',
}

exec { 'install-properties':
    command => "/usr/bin/apt-get install -y python-software-properties",
    require => Exec["update"],
}

# nginx

exec { "add-nginx-package":
    command => "/usr/bin/add-apt-repository -y ppa:nginx/stable && /usr/bin/apt-get update",
    require => Exec["install-properties"],
}

package { 'nginx': 
    ensure  => present,
    require => Exec['add-nginx-package'],
}

service { 'nginx':
    ensure  => running,
    require => Package['nginx'],
}

file { "nginx-vhost":
    path    => "/etc/nginx/sites-available/default",
    ensure  => file,
    replace => true,
    require => Package["nginx"],
    source  => 'puppet:///modules/nginx/default',
    notify  => Service["nginx"],
}


# golang version
$version = "1.1.2"

exec { "download-golang":
    command => "/usr/bin/wget -O /usr/local/src/go${version}.linux-amd64.tar.gz https://go.googlecode.com/files/go${version}.linux-amd64.tar.gz",
    creates => "/usr/local/src/go${version}.linux-amd64.tar.gz",
}

exec { "unarchive-golang-tools":
    command => "/bin/tar -C /usr/local -xzf /usr/local/src/go${version}.linux-amd64.tar.gz",
    require => Exec["download-golang"],
}

exec { "setup-path":
    command => "/bin/echo 'export PATH=/vagrant/bin:/usr/local/go/bin:\$PATH' >> /home/vagrant/.profile",
    unless  => "/bin/grep -q /usr/local/go /home/vagrant/.profile ; /usr/bin/test $? -eq 0",
}

exec { "setup-workspace":
    command => "/bin/echo 'export GOPATH=/vagrant' >> /home/vagrant/.profile",
    unless  => "/bin/grep -q GOPATH /home/vagrant/.profile ; /usr/bin/test $? -eq 0"
}

# php

package { "php5-fpm":
    ensure  => present,
    require => Exec["update"],
}

service { "php5-fpm":
    ensure  => running,
    require => Package["php5-fpm"],
}

# nodejs

exec { "add-nodejs-package":
    command => "/usr/bin/add-apt-repository -y ppa:chris-lea/node.js && /usr/bin/apt-get update",
    require => Exec["install-properties"],
}

package { "nodejs":
    ensure  => present,
    require => Exec["add-nodejs-package"],
}
