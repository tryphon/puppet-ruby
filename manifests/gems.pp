class ruby::gems {
  include ruby::dev

  package { rubygems: 
    ensure => latest
  }

  if $debian_lenny {
    include apt::tryphon
    Package[rubygems] {
      require => [Apt::Sources_list[tryphon], Apt::Preferences[rubygems]]
    }
    apt::preferences { rubygems:
      package => rubygems, 
      pin => "release a=lenny-backports",
      priority => 999
    }
    apt::preferences { "rubygems18":
      package => "rubygems1.8", 
      pin => "release a=lenny-backports",
      priority => 999
    }
  }

  file { "/etc/gemrc":
    content => "gem: --no-rdoc --no-ri\n"
  }
}

class ruby::gem::fog::dependencies {
  include ruby::gem::nokogiri::dependencies
}

class ruby::gem::nokogiri::dependencies {
  include ruby::gems

  package { [libxml2-dev, zlib1g-dev]: }  
  package { libxslt1-dev: }  
}

class ruby::gem::sqlite3::dependencies {
  include ruby::gems

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

class ruby::gem::rmagick::dependencies {
  package { libmagickwand-dev: }
}
