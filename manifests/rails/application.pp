define rails::application(
  $server_name   = false,
  $rails_version = '2.3.5',
  $mongodb       = false,
  $mongoid_file  = '',
  $database      = nil,
  $database_file = '',
  $environment   = 'production',
  $env_file      = '',
  $ruby_version  = false,
  $newrelic      = false,
  $newrelic_file = '',
  $sidekiq       = false,
  $secrets       = false,
  $secrets_file  = '',
  $backend       = 'apache2') {
  if $server_name {
    $site_name = regsubst($server_name, '\.', '_', 'G')
    case $backend {
      'apache2': {
        apache2::site { $site_name:
          content => template("ruby/rails/apache.conf")
        }}
      'nginx': {
        nginx::site { $site_name:
          content => template("ruby/rails/nginx.conf")
        }}
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
    mode   => '2775',
    group  => src
  }
  file { "/var/www/$name/shared/config":
    ensure => "/etc/$name",
    force  => true
  }

  if ! defined(File["/etc/$name"]) {
    file { "/etc/$name":
      ensure => directory
    }
  }

  file { "/etc/$name/environments":
    ensure => directory
  }

  $env_source = $env_file? {
    ''      => ["puppet:///files/$name/$environment.rb.$fqdn", "puppet:///files/$name/$environment.rb"],
    default => $env_file
  }

  file { "/etc/$name/environments/$environment.rb":
    source => $env_source,
    notify => Exec["restart-$name"]
  }

  file { "/etc/$name/$environment.rb":
    ensure => link,
    target => "/etc/$name/environments/$environment.rb"
  }

  $mongoid_source = $mongoid_file? {
    ''      => ["puppet:///files/$name/mongoid.yml.$fqdn", "puppet:///files/$name/mongoid.yml.$environment", "puppet:///files/$name/mongoid.yml"],
    default => $mongoid_file
  }
  if $mongodb {
    file { "/etc/$name/mongoid.yml":
      source => $mongoid_source,
      notify => Exec["restart-$name"]
    }
  }

  $secrets_source = $secrets_file? {
    ''      => ["puppet:///files/$name/secrets.yml.$fqdn", "puppet:///files/$name/secrets.yml.$environment", "puppet:///files/$name/secrets.yml"],
    default => $secret_file
  }
  if $secrets {
    file { "/etc/$name/secrets.yml":
      source => $secrets_source
      notify => Exec["restart-$name"]
    }
  }

  if $database == nil {
    $real_database=!$mongodb
  } else {
    $real_database=$database
  }

  $database_source = $database_file? {
    ''      => ["puppet:///files/$name/database.yml.$fqdn", "puppet:///files/$name/database.yml.$environment", "puppet:///files/$name/database.yml"],
    default => $database_file
  }
  if $real_database {
    file { "/etc/$name/database.yml":
      source => $database_source,
      notify => Exec["restart-$name"]
    }
  }

  $newrelic_source = $newrelic_file? {
    ''      => ["puppet:///files/$name/newrelic.yml.$fqdn", "puppet:///files/$name/newrelic.yml.$environment", "puppet:///files/$name/newrelic.yml"],
    default => $newrelic_file
  }
  if $newrelic {
    file { "/etc/$name/newrelic.yml":
      source => $newrelic_source,
      mode   => '0644',
      notify => Exec["restart-$name"]
    }
  }

  if $sidekiq {
    file { "/etc/init.d/sidekiq-$name":
      source  => "puppet:///modules/ruby/sidekiq/sidekiq.initd",
      mode    => '0755',
      require => File['/usr/local/bin/sidekiq-start']
    }

    service { "sidekiq-$name":
      ensure    => running,
      hasstatus => true,
      require   => File["/etc/init.d/sidekiq-$name"],
      subscribe => File["/etc/$name/environments/$environment.rb"]
    }

    if $environment != "production" {
      file { "/etc/default/sidekiq-$name":
        content => "RAILS_ENV=$environment\n"
      }
    }
  }

  exec { "restart-$name":
    refreshonly => true,
    command     => "touch /var/www/$name/current/tmp/restart.txt",
    onlyif      => "test -d /var/www/$name/current/tmp/"
  }

}
