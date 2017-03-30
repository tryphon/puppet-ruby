class ruby($version = '2.1') {
  include debian::build_essential

  package { ["ruby${version}", "ruby${version}-dev"]: }
}
