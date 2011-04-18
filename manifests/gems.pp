class ruby::gems {
  include ruby::dev
  include apt::tryphon

  package { rubygems: 
    ensure => latest,
    require => [Apt::Sources_list[tryphon], Apt::Preferences[rubygems]]
  }

  apt::preferences { rubygems:
    package => rubygems, 
    pin => "release a=lenny-backports",
    priority => 999
  }
  apt::preferences { "rubygems1.8":
    package => "rubygems1.8", 
    pin => "release a=lenny-backports",
    priority => 999
  }

  file { "/etc/gemrc":
    content => "gem: --no-rdoc --no-ri
"
  }
}

class ruby::gem::nokogiri::dependencies {
  include ruby::gems

  package { [libxml2-dev, zlib1g-dev]: }  
  package { libxslt1-dev: }  
}

class ruby::gem::sqlite3::dependencies {
  include ruby::gems

  package { libsqlite3-dev:
    require => Apt::Preferences[libsqlite3-dev]
  }
  apt::preferences { libsqlite3-dev:
    package => libsqlite3-dev,
    pin => "release a=lenny-backports",
    priority => 999,
    require => Apt::Preferences[libsqlite3]
  }
  apt::preferences { libsqlite3:
    package => libsqlite3-0,
    pin => "release a=lenny-backports",
    priority => 999
  }
}
