class ruby::mysql {
  include ruby::gems
  include mysql::client  
  package { libmysqlclient15-dev: }

  ruby::gem { mysql: require => Package[libmysqlclient15-dev] }
}
