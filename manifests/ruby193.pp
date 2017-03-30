class ruby::ruby193 {
  include apt::bearstech

  package { "ruby1.9.1":
    require => Apt::Sources_list["bearstech"]
  }

  file { "/var/lib/gems/1.9.1/bin":
    ensure  => directory,
    require => Package["ruby1.9.1"]
  }
  file { "/usr/lib/ruby/1.9.1/rubygems/defaults.rb":
    source  => 'puppet:///modules/ruby/defaults-1.9.1.rb',
    require => Package["ruby1.9.1"]
  }
  # Gems binaries should go to /var/lib/gems/1.9.1/bin
}
