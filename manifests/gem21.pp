define ruby::gem21($ensure = 'present') {
  include ruby::gems::21
  # remove me if package { provider => gem } can support gem2.0
  exec { "ruby-gem21-install-$name":
    command => "gem2.1 install $name",
    unless  => "gem2.1 list $name | grep '^$name '",
    require => [Package["ruby2.1"],Package["ruby2.1-dev"], Package[build-essential], File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]]
  }
}
