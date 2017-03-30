class ruby::dev {
  if $debian::lenny or $debian::squeeze or $debian::wheezy {
    include ruby::dev_193
  } else {
    package { ['ruby', 'ruby-dev']: }
    include debian::build_essential
  }
}
