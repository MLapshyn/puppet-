class unzip {
  package{'unzip':
    ensure => installed,
    before => Class["jboss::install"],
  }
}
