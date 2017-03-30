class ruby::ruby22 {
  include apt::bearstech

  package { "ruby2.2":
    require => Apt::Sources_list["bearstech"],
    before  => File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]
  }
  include ruby::multiversion::2

  file { ["/var/lib/gems/2.2.0", "/var/lib/gems/2.2.0/bin"]:
    ensure => directory,
    before => File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]
  }

  # rake gem is present in bearstech package but rake script isn't present into /var/lib/gems/2.2.0/bin/rake
  exec { 'ruby-gem22-fix-rake':
    command => 'gem2.2 install rake',
    creates => '/var/lib/gems/2.2.0/bin/rake',
    require => File['/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb']
  }
}
