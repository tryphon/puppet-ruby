class ruby::ruby21 {
  include apt::bearstech

  package { "ruby2.1":
    require => Apt::Sources_list["bearstech"],
    before  => File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]
  }
  include ruby::multiversion::2

  file { ["/var/lib/gems/2.1.0", "/var/lib/gems/2.1.0/bin"]:
    ensure => directory,
    before => File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]
  }
}
