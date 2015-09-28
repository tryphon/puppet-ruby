define ruby::gem($ensure = 'present') {
  include ruby::gems
  package { $name:
    ensure => $ensure,
    provider => gem,
    require => [Package[ruby-dev], Package[rubygems], Package[build-essential]]
  }
}

define ruby::gem193($ensure = 'present') {
  $version = $ensure ? {
    'present' => '.*',
    default => $ensure
  }
  include ruby::gems::193
  # remove me if package { provider => gem } can support gem2.0
  exec { "ruby-gem193-install-$name":
    command => "gem1.9.1 install $name",
    unless => "gem1.9.1 list $name | grep '^$name ($version)'",
    require => [Package["ruby1.9.1"],Package["ruby1.9.1-dev"], Package[build-essential], File["/usr/lib/ruby/1.9.1/rubygems/defaults.rb"]]
  }
}

define ruby::gem20($ensure = 'present') {
  include ruby::gems::20
  # remove me if package { provider => gem } can support gem2.0
  exec { "ruby-gem20-install-$name":
    command => "gem2.0 install $name",
    unless => "gem2.0 list $name | grep '^$name '",
    require => [Package["ruby2.0"],Package["ruby2.0-dev"], Package[build-essential], File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]]
  }
}

define ruby::gem21($ensure = 'present') {
  include ruby::gems::21
  # remove me if package { provider => gem } can support gem2.0
  exec { "ruby-gem21-install-$name":
    command => "gem2.1 install $name",
    unless => "gem2.1 list $name | grep '^$name '",
    require => [Package["ruby2.1"],Package["ruby2.1-dev"], Package[build-essential], File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]]
  }
}

define ruby::gem22($ensure = 'present') {
  include ruby::gems::22
  # remove me if package { provider => gem } can support gem2.0
  exec { "ruby-gem22-install-$name":
    command => "gem2.2 install $name",
    unless => "gem2.2 list $name | grep '^$name '",
    require => [Package["ruby2.2"],Package["ruby2.2-dev"], Package[build-essential], File["/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb"]]
  }
}
