class ruby::onrails($backend = "apache2") {
  case $backend {
    'apache2': { include apache2::passenger }
    'nginx'  : { include nginx::passenger }
  }
  # include ruby::gems
  # include ruby::rake
  # include ruby::irb
  # include ruby::syslog
  include ruby::capistrano::target
  include ruby::whenever

  file { "/usr/local/bin/rails-console":
    source => "puppet:///ruby/rails-console",
    mode => 755
  }
}
