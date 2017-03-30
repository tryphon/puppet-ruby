define ruby::gem22($ensure = 'present') {
  include ruby::gems::22
  # remove me if package { provider => gem } can support gem2.0
  exec { "ruby-gem22-install-$name":
    command => "gem2.2 install $name",
    unless  => "gem2.2 list $name | grep '^$name '",
    require => [Package["ruby2.2"],Package["ruby2.2-dev"], Package[build-essential], File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]]
  }
}
