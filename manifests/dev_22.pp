class ruby::dev_22 {
  include ruby::ruby22
  include debian::build_essential

  package { "ruby2.2-dev":
  }
}
