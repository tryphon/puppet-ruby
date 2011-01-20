define rails::application($server_name = false, $rails_version = '2.3.5') {
  if $server_name {
    $site_name = regsubst($server_name, '\.', '_', 'G')
    apache2::site { $site_name:
      content => template("ruby/rails/apache.conf")
    }
  }

  if $rails_version {
    # a simple ruby::gem/package doesn't support several versions of the same gem
    exec { "gem-install-rails-$rails_version-for-$name":
      command => "gem install --version $rails_version rails",
      unless => "gem list rails | grep '^rails ' | grep '[( ]$rails_version[,)]'"
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

  file { 
    "/etc/$name": ensure => directory;
    "/etc/$name/database.yml": source => ["puppet:///files/$name/database.yml.$fqdn", "puppet:///files/$name/database.yml"], notify => Exec["restart-$name"];
    "/etc/$name/production.rb": source => ["puppet:///files/$name/production.rb.$fqdn", "puppet:///files/$name/production.rb"], notify => Exec["restart-$name"];
  }

  exec { "restart-$name":
    refreshonly => true,
    command => "touch /var/www/$name/current/tmp/restart.txt",
    onlyif => "test -d /var/www/$name/current/tmp/"
  }

}
