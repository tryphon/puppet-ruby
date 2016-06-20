class ruby::whenever {
  file { '/usr/local/sbin/whenever-sudo':
    source => 'puppet:///modules/ruby/whenever/whenever-sudo',
    mode => 755
  }
  sudo::user_line { 'whenever-sudo':
    line => '%src	ALL=NOPASSWD: /usr/local/sbin/whenever-sudo',
    require => File['/usr/local/sbin/whenever-sudo']
  }
}
