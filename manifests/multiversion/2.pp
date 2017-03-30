class ruby::multiversion::2 {
  # Small patch to install gem binaries in /var/lib/gems/2.0.0/bin
  #
  # def self.default_bindir
  #  "/var/lib/gems/#{ConfigMap[:ruby_version]}/bin"
  # end
  file { "/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb":
    source => "puppet:///modules/ruby/operating_system.rb"
  }
  file { "/var/lib/gems": ensure => directory }
}
