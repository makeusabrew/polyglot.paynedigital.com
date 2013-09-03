class { "apt": }

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
