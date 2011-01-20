class ruby::bundler {
  include ruby::gems

  # FIXME: troubles with Rails 2.3.8 and bundler >= 1.0.8
  ruby::gem { bundler: ensure => "1.0.7" }

  file { "/usr/local/bin/bundle":
    ensure => "/var/lib/gems/1.8/bin/bundle",
    require => Ruby::Gem[bundler]
  }
}
