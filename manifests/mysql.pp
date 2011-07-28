class ruby::mysql {
  include ruby::gems
  include mysql::client  
  package { libmysqlclient-dev: }

  ruby::gem { mysql: require => Package[libmysqlclient-dev] }
}
