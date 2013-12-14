class ruby::rakeapp {
  include apache2::passenger
  include ruby::bundler
  include ruby::syslog
  include ruby::capistrano::target
}
