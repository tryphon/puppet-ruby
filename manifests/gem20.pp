define ruby::gem20($ensure = 'present') {
  include ruby::gems::20
  # remove me if package { provider => gem } can support gem2.0
  exec { "ruby-gem20-install-$name":
    command => "gem2.0 install $name",
    unless  => "gem2.0 list $name | grep '^$name '",
    require => [Package["ruby2.0"],Package["ruby2.0-dev"], Package[build-essential], File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]]
  }
}
