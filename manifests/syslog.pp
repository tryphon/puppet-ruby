class ruby::syslog {
  ruby::gem { SyslogLogger: require => Ruby::Gem[hoe] }
  # hoe > 2.9 requires rubygems 1.4
  ruby::gem { hoe: ensure => '2.8.0' }
}
