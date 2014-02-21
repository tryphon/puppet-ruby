class << Gem

  alias :upstream_default_dir :default_dir
  def default_dir
    File.join('/', 'var', 'lib', 'gems', Gem::ConfigMap[:ruby_version])
  end

  alias :upstream_default_bindir :default_bindir
  def default_bindir
    File.join(default_dir, 'bin')
  end

  alias :upstream_default_path :default_path
  def default_path
    upstream_default_path + [File.join('/usr/share/rubygems-integration', Gem::ConfigMap[:ruby_version])]
  end

end
