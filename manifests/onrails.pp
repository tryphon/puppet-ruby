class ruby::onrails {
  include apache2::passenger
  include ruby::gems
  include ruby::rake
  include ruby::irb
  include ruby::syslog
  include git::common
}
