class ruby::capistrano {
  ruby::gem { [capistrano, capistrano-ext]: }

  file { "/usr/local/sbin/cap-fix-permissions":
    source => "puppet:///ruby/cap-fix-permissions",
    mode => 755
  }

  sudo::user_line { "cap-fix-permissions":
    line => "%src	ALL=NOPASSWD: /usr/local/sbin/cap-fix-permissions"
  }
}
