class ruby::gemrc {
  file { "/etc/gemrc":
    content => "gem: --no-rdoc --no-ri\n"
  }
}
