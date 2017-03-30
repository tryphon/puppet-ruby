class ruby::dev_20 {
  include ruby::ruby20
  include debian::build_essential

  package { "ruby2.0-dev":
  }
}
