define ruby::gem($ensure = 'present') {
  include ruby::gems
  package { $name:
    ensure   => $ensure,
    provider => gem,
    require  => [Package['ruby-dev'], Package['build-essential']]
  }
}
