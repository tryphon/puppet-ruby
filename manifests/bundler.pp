class ruby::bundler {
  include ruby::gems
  ruby::gem { bundler: ensure => latest }
}
