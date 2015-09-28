class ruby::dev {
  package { ruby-dev: }
  include debian::build-essential
}

class ruby::dev::193 {
  include ruby193
  include bearstech::apt
  include debian::build-essential

  package { "ruby1.9.1-dev":
    require => Apt::Sources_list["bearstech"]
  }
}

class ruby::dev::20 {
  include ruby20
  include bearstech::apt
  include debian::build-essential

  package { "ruby2.0-dev":
    require => Apt::Sources_list["bearstech"]
  }
}

class ruby::dev::21 {
  include ruby21
  include bearstech::apt
  include debian::build-essential

  package { "ruby2.1-dev":
    require => Apt::Sources_list["bearstech"]
  }
}

class ruby::dev::22 {
  include ruby22
  include bearstech::apt
  include debian::build-essential

  package { "ruby2.2-dev":
    require => Apt::Sources_list["bearstech"]
  }
}
