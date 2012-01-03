class ruby::capistrano {
  ruby::gem { [capistrano, capistrano-ext]: }
}

# Tools used remotely by capistrano scripts
class ruby::capistrano::target {
  include git::common

  file { "/usr/local/sbin/cap-fix-permissions":
    source => "puppet:///ruby/cap-fix-permissions",
    mode => 755
  }

  sudo::user_line { "cap-fix-permissions":
    line => "%src	ALL=NOPASSWD: /usr/local/sbin/cap-fix-permissions"
  }
}
