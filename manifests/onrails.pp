class ruby::onrails {
  include apache2::passenger
  # include ruby::gems
  # include ruby::rake
  # include ruby::irb
  # include ruby::syslog
  include ruby::capistrano::target

  file { "/usr/local/bin/rails-console":
    source => "puppet:///ruby/rails-console",
    mode => 755
  }
}
