class ruby::onrails($backend = 'apache2') {
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

  file { '/usr/local/bin/rails-console':
    source => 'puppet:///ruby/rails-console',
    mode   => 0755
  }

  sudo::user_line { "passenger-config":
    line => "%src	ALL=NOPASSWD: /usr/bin/env passenger-config restart-app /var/www/[a-zA-Z0-9-_]*"
  }
}
