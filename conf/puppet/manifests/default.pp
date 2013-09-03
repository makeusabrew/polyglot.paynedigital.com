# general packages & services

class { "apt": }

# nginx

apt::ppa { "ppa:nginx/stable": }

package { 'nginx':
    ensure  => present,
    require => Apt::Ppa["ppa:nginx/stable"],
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
    unless  => "/usr/bin/test -d /usr/local/go/bin",
    require => Exec["download-golang"],
}

exec { "setup-path":
    command => "/bin/echo 'export PATH=/vagrant/bin:/usr/local/go/bin:\$PATH' >> /home/vagrant/.profile",
    unless  => "/bin/grep -q /usr/local/go /home/vagrant/.profile ; /usr/bin/test $? -eq 0",
}

exec { "setup-workspace":
    command => "/bin/echo 'export GOPATH=/vagrant' >> /home/vagrant/.profile",
    unless  => "/bin/grep -q GOPATH /home/vagrant/.profile ; /usr/bin/test $? -eq 0",
}

# php

package { "php5-fpm":
    ensure  => present,
}

service { "php5-fpm":
    ensure  => running,
    require => Package["php5-fpm"],
}

# nodejs

apt::ppa { "ppa:chris-lea/node.js": }

package { "nodejs":
    ensure  => present,
    require => Apt::Ppa["ppa:chris-lea/node.js"],
}
