class nodejs {

    apt::ppa { "ppa:chris-lea/node.js": }

    package { "nodejs":
        ensure  => present,
        require => Apt::Ppa["ppa:chris-lea/node.js"],
    }
}
