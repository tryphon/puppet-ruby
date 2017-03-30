class ruby::dev_193 {
  include ruby::ruby193
  include debian::build_essential

  package { "ruby1.9.1-dev":
    alias   => 'ruby-dev',
  }
}
