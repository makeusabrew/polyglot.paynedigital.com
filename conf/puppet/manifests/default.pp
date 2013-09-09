class { "nginx": }

class { "nodejs": }

class { "golang": }

# php

package { "php5-fpm":
    ensure  => present,
}

service { "php5-fpm":
    ensure  => running,
    require => Package["php5-fpm"],
}

package { "php5-mysql":
    ensure => present,
    notify => Service["php5-fpm"],
}

$php_src = "/vagrant/src/php"

# php *code*
exec { "php npm dependencies":
    command => "/usr/bin/npm install",
    cwd     => $php_src,
    require => Package["nodejs"],
}

file { "php logs directory":
    ensure => directory,
    group  => "www-data",
    mode   => 0775,
    path   => "$php_src/log",
}

file { "php tmp directory":
    ensure => directory,
    group  => "www-data",
    mode   => 0775,
    path   => "$php_src/tmp/templates_c",
}
