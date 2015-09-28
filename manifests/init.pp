import "definitions/*.pp"

class ruby193 {
  include bearstech::apt

  package { "ruby1.9.1":
    require => Apt::Sources_list["bearstech"]
  }

  file { "/var/lib/gems/1.9.1/bin":
    ensure => directory,
    require => Package["ruby1.9.1"]
  }
  file { "/usr/lib/ruby/1.9.1/rubygems/defaults.rb":
    source => "puppet:///modules/ruby/defaults-1.9.1.rb",
    require => Package["ruby1.9.1"]
  }
  # Gems binaries should go to /var/lib/gems/1.9.1/bin
}

class ruby20 {
  include bearstech::apt

  package { "ruby2.0":
    require => Apt::Sources_list["bearstech"],
    before => File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]
  }
  include ruby::multiversion::2

  file { ["/var/lib/gems/2.0.0", "/var/lib/gems/2.0.0/bin"]:
    ensure => directory,
    before => File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]
  }
}

class ruby21 {
  include bearstech::apt

  package { "ruby2.1":
    require => Apt::Sources_list["bearstech"],
    before => File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]
  }
  include ruby::multiversion::2

  file { ["/var/lib/gems/2.1.0", "/var/lib/gems/2.1.0/bin"]:
    ensure => directory,
    before => File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]
  }
}

class ruby22 {
  include bearstech::apt

  package { "ruby2.2":
    require => Apt::Sources_list["bearstech"],
    before => File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]
  }
  include ruby::multiversion::2

  file { ["/var/lib/gems/2.2.0", "/var/lib/gems/2.2.0/bin"]:
    ensure => directory,
    before => File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]
  }
}

class ruby::multiversion::2 {
  # Small patch to install gem binaries in /var/lib/gems/2.0.0/bin
  #
  # def self.default_bindir
  #  "/var/lib/gems/#{ConfigMap[:ruby_version]}/bin"
  # end
  file { "/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb":
    source => "puppet:///modules/ruby/operating_system.rb"
  }
  file { "/var/lib/gems": ensure => directory }
}
