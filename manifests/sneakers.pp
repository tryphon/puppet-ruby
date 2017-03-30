class ruby::sneakers {
  file { "/usr/local/bin/sneakers-start":
    source => "puppet:///modules/ruby/sneakers/sneakers-start",
    mode   => '0755'
  }

  file { "/usr/local/sbin/sneakers-touch":
    source => "puppet:///modules/ruby/sneakers/sneakers-touch",
    mode   => '0755'
  }
  sudo::user_line { 'sneakers-touch':
    line    => "%src	ALL=NOPASSWD: /usr/local/sbin/sneakers-touch",
    require => File["/usr/local/sbin/sneakers-touch"]
  }

  define instance($environment = 'production') {
    file { "/etc/init.d/sneakers-$name":
      source  => "puppet:///modules/ruby/sneakers/sneakers.initd",
      mode    => '0755',
      require => File['/usr/local/bin/sneakers-start']
    }

    service { "sneakers-$name":
      ensure    => running,
      hasstatus => true,
      require   => File["/etc/init.d/sneakers-$name"],
      subscribe => File["/etc/$name/environments/$environment.rb"]
    }

    if $environment != "production" {
      file { "/etc/default/sneakers-$name":
        content => "RAILS_ENV=$environment\n"
      }
    }
  }
}
