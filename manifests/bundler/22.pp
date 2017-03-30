class ruby::bundler::22 {
  include ruby::gems::22
  ruby::gem22 { bundler: ensure => latest }
}
