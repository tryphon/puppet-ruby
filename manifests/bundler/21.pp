class ruby::bundler::21 {
  include ruby::gems::21
  ruby::gem21 { bundler: ensure => latest }
}
