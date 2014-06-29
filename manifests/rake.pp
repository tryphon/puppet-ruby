class ruby::rake {
  # rake package is too old into lenny
  ruby::gem { rake: }

  # file { "/usr/local/bin/rake":
  #   ensure => "/var/lib/gems/1.8/bin/rake"
  # }

  define application($server_name = false, $environment = "production", $ruby_version = false) {
    if $server_name {
      $site_name = regsubst($server_name, '\.', '_', 'G')
      apache2::site { $site_name:
        content => template("ruby/rails/apache.conf")
      }
    }

    file { ["/var/www/$name", "/var/www/$name/shared"]:
      ensure => directory,
      mode => 2775,
      group => src
    }
    file { "/var/www/$name/shared/config":
      ensure => "/etc/$name",
      force => true
    }

    if ! defined(File["/etc/$name"]) {
      file { "/etc/$name":
        ensure => directory
      }
    }

    exec { "restart-$name":
      refreshonly => true,
      command => "touch /var/www/$name/current/tmp/restart.txt",
      onlyif => "test -d /var/www/$name/current/tmp/"
    }
  }
}
