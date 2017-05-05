class ruby::gems {
  include ruby::dev
  include ruby::gemrc
}

class ruby::gem::sqlite3::dependencies {
  package { libsqlite3-dev: }

  if $debian::lenny {
    include apt::backports
    apt::preferences { libsqlite3-dev:
      package => libsqlite3-dev,
      pin => "release a=lenny-backports",
      priority => 999,
      require => Apt::Preferences[libsqlite3],
      before => Package[libsqlite3-dev]
    }
    apt::preferences { libsqlite3:
      package => libsqlite3-0,
      pin => "release a=lenny-backports",
      priority => 999
    }
  }
}

class ruby::gem::rtaglib::dependencies {
  package { [libtagc0-dev, libtag1-dev]: }
}

class ruby::gem::proj4rb::dependencies {
  package { libproj-dev: }
}

class ruby::gem::ffi_proj4::dependencies {
  package { 'libproj-dev': }
}

class ruby::gem::rgeo::dependencies {
  include ruby::gem::proj4rb::dependencies
  package { 'libgeos-dev': }
}

class ruby::gem::rmagick::dependencies {
  package { libmagickwand-dev: }
}

class ruby::gem::curl::dependencies {
  package { 'libcurl4-gnutls-dev': }
}

class ruby::gem::mysql::dependencies {
  include mysql::client

  if $debian::lenny {
    package { libmysqlclient15-dev: alias => libmysqlclient-dev }
  } else {
    package { libmysqlclient-dev: }
  }
}

class ruby::gem::mahoro::dependencies {
  package { libmagic-dev: }
}

class ruby::gem::bzip2::dependencies {
  package { libbz2-dev: }
}

class ruby::gem::taglib_ruby::dependencies {
  package { 'libtag1-dev': }
}

class ruby::gem::postgresql::dependencies {
  package { 'libpq-dev': }
}

class ruby::gem::capybara_webkit {
  package { 'libqtwebkit-dev': }
}

class ruby::gem::curl::dependencies {
  package { 'libcurl4-openssl-dev': }
}
