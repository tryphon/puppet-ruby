class ruby::dev_21 {
  include ruby::ruby21
  include debian::build_essential

  package { "ruby2.1-dev":
  }
}
