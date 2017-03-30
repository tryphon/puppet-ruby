define ruby::delayed_job::initd() {
  file { "/etc/init.d/$name":
    source => "puppet:///modules/ruby/delayed_job.init",
    mode => '0755'
  }

  exec { "insserv-$name":
    command => "insserv $name",
    require => File["/etc/init.d/$name"],
    unless => "ls /etc/rc?.d/S*$name > /dev/null 2>&1"
  }
}
