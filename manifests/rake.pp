class ruby::rake {
  # rake package is too old into lenny
  ruby::gem { rake: }

  # file { "/usr/local/bin/rake":
  #   ensure => "/var/lib/gems/1.8/bin/rake"
  # }
}
