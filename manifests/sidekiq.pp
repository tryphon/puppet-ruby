class ruby::sidekiq {
  file { "/usr/local/bin/sidekiq-start":
    source => "puppet:///modules/ruby/sidekiq/sidekiq-start",
    mode => 755
  }

  file { "/usr/local/sbin/sidekiq-touch":
    source => "puppet:///modules/ruby/sidekiq/sidekiq-touch",
    mode => 755
  }
  sudo::user_line { 'sidekiq-touch':
    line => "%src	ALL=NOPASSWD: /usr/local/sbin/sidekiq-touch",
    require => File["/usr/local/sbin/sidekiq-touch"]
  }
}
