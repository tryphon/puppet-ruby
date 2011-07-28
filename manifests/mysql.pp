class ruby::mysql {
  include ruby::gems
  include mysql::client  

  if $debian::lenny {
    package { libmysqlclient15-dev: alias => libmysqlclient-dev }
  } else {
    package { libmysqlclient-dev: }
  }

  ruby::gem { mysql: require => Package[libmysqlclient-dev] }
}
