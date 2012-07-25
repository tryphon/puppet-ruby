class ruby::mysql {
  include ruby::gem::mysql::dependencies
  ruby::gem { mysql: require => Package[libmysqlclient-dev] }
}

