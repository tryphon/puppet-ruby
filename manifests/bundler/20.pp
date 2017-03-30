class ruby::bundler::20 {
  include ruby::gems::20
  ruby::gem20 { bundler: ensure => latest }
}
