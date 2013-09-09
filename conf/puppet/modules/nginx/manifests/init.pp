class nginx {

    include "apt"

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
}
