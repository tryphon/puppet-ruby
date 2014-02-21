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
}

class ruby20 {
  include bearstech::apt

  package { "ruby2.0":
    require => Apt::Sources_list["bearstech"]
  }
  file { "/var/lib/gems/2.0.0/bin":
    ensure => directory,
    require => Package["ruby2.0"]
  }
  # Small patch to install gem binaries in /var/lib/gems/2.0.0/bin
  #
  # def self.default_bindir
  #  "/var/lib/gems/#{ConfigMap[:ruby_version]}/bin"
  # end
  file { "/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb":
    source => "puppet:///modules/ruby/operating_system.rb",
    require => Package["ruby2.0"]
  }
}
