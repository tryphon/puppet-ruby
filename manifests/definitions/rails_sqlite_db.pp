define rails::sqlite_db() {
  file { 
    "/var/lib/$name": 
    ensure => directory;
    "/var/lib/$name/db": 
    ensure => directory, owner => www-data, group => src, mode => 2775;
    "/var/lib/$name/db/production.sqlite3": 
    owner => www-data, group => src, mode => 664;
  }

  # shared/db is used by capistrano to fix file permissions if needed
  file { "/var/www/$name/shared/db":
    ensure => "/var/lib/$name/db",
    force => true
  }
}
