class ruby::bundler {
  include ruby::gems

  ruby::gem { bundler: }

  # file { "/usr/local/bin/bundle":
  #   ensure => "/var/lib/gems/1.8/bin/bundle",
  #   require => Ruby::Gem[bundler]
  # }
}
