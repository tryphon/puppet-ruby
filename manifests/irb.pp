class ruby::irb {
  # irb is provided by ruby package after lenny
  if $debian::lenny {
    package { irb: }
  }
}
