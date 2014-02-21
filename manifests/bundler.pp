class ruby::bundler {
  include ruby::gems

  ruby::gem { bundler: ensure => latest }

  # file { "/usr/local/bin/bundle":
  #   ensure => "/var/lib/gems/1.8/bin/bundle",
  #   require => Ruby::Gem[bundler]
  # }
}

class ruby::bundler::193 {
  include ruby::gems::193
  ruby::gem193 { bundler: ensure => latest }
}

class ruby::bundler::20 {
  include ruby::gems::20
  ruby::gem20 { bundler: ensure => latest }
}
