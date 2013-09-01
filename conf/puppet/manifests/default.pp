exec { 'apt-get update': 
    command => '/usr/bin/apt-get update'
}

exec { 'install-properties':
    command => "/usr/bin/apt-get install -y python-software-properties",
    require => Exec["apt-get update"]
}

exec { "update-nginx":
    command => "/usr/bin/add-apt-repository -y ppa:nginx/stable && /usr/bin/apt-get update",
    require => Exec["install-properties"]
}

package { 'nginx': 
    ensure => present,
    require => Exec['update-nginx']
}

service { 'nginx':
    ensure => running,
    require => Package['nginx']
}

# golang version
$version = "1.1.2"

exec { "download-golang":
    command => "/usr/bin/wget -O /usr/local/src/go$version.linux-amd64.tar.gz https://go.googlecode.com/files/go$version.linux-amd64.tar.gz",
    creates => "/usr/local/src/go$version.linux-amd64.tar.gz"
}

exec { "unarchive-golang-tools":
    command => "/bin/tar -C /usr/local -xzf /usr/local/src/go$version.linux-amd64.tar.gz",
    require => Exec["download-golang"]
}

exec { "setup-path":
    command => "/bin/echo 'export PATH=/vagrant/bin:/usr/local/go/bin:\$PATH' >> /home/vagrant/.profile"
}

exec { "setup-workspace":
    command => "/bin/echo 'export GOPATH=/vagrant' >> /home/vagrant/.profile"
}
