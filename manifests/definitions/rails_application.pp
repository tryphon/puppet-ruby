define rails::application($server_name = false, $rails_version = '2.3.5', $mongodb = false, $database = nil, $environment = "production", $ruby_version = false, $newrelic = false, $sidekiq = false, $secrets = false) {
  if $server_name {
    $site_name = regsubst($server_name, '\.', '_', 'G')
    apache2::site { $site_name:
      content => template("ruby/rails/apache.conf")
    }
  }

  if $rails_version {
    notice("rails_version is no longer supported. Use bundler ...")
    # # a simple ruby::gem/package doesn't support several versions of the same gem
    # exec { "gem-install-rails-$rails_version-for-$name":
    #   command => "gem install --version $rails_version rails",
    #   unless => "gem list rails | grep '^rails ' | grep '[( ]$rails_version[,)]'"
    # }
  }

  file { ["/var/www/$name", "/var/www/$name/shared", "/var/www/$name/shared/public"]:
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

  file { "/etc/$name/environments":
    ensure => directory
  }

  file { "/etc/$name/environments/$environment.rb":
    source => ["puppet:///files/$name/$environment.rb.$fqdn", "puppet:///files/$name/$environment.rb"],
    notify => Exec["restart-$name"]
  }

  file { "/etc/$name/$environment.rb":
    ensure => link,
    target => "/etc/$name/environments/$environment.rb"
  }

  if $mongodb {
    file { "/etc/$name/mongoid.yml":
      source => ["puppet:///files/$name/mongoid.yml.$fqdn", "puppet:///files/$name/mongoid.yml.$environment", "puppet:///files/$name/mongoid.yml"],
      notify => Exec["restart-$name"]
    }
  }

  if $secrets {
    file { "/etc/$name/secrets.yml":
      source => ["puppet:///files/$name/secrets.yml.$fqdn", "puppet:///files/$name/secrets.yml.$environment", "puppet:///files/$name/secrets.yml"],
      notify => Exec["restart-$name"]
    }
  }

  if $database == nil {
    $real_database=!$mongodb
  } else {
    $real_database=$database
  }

  if $real_database {
    file { "/etc/$name/database.yml":
      source => ["puppet:///files/$name/database.yml.$fqdn", "puppet:///files/$name/database.yml.$environment", "puppet:///files/$name/database.yml"],
      notify => Exec["restart-$name"]
    }
  }

  if $newrelic {
    file { "/etc/$name/newrelic.yml":
      source => ["puppet:///files/$name/newrelic.yml.$fqdn", "puppet:///files/$name/newrelic.yml.$environment", "puppet:///files/$name/newrelic.yml"],
      mode => 644,
      notify => Exec["restart-$name"]
    }
  }

  if $sidekiq {
    file { "/etc/init.d/sidekiq-$name":
      source => "puppet:///ruby/sidekiq/sidekiq.initd",
      mode => 755,
      require => File['/usr/local/bin/sidekiq-start']
    }

    service { "sidekiq-$name":
      ensure => running,
      hasstatus => true,
      require => File["/etc/init.d/sidekiq-$name"]
    }
  }

  exec { "restart-$name":
    refreshonly => true,
    command => "touch /var/www/$name/current/tmp/restart.txt",
    onlyif => "test -d /var/www/$name/current/tmp/"
  }

}
