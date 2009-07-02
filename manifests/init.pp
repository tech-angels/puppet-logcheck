class logcheck {
  # install package
  package { "logcheck":
    ensure => present,
  }

  # our logs will be in /srv/logcheck/<hostname> so we have to create parents.
  file {"/srv/logcheck":
    ensure => directory
  }

  # config
  file {"/etc/logcheck/logcheck.conf":
    ensure => present,
    content => template("logcheck/logcheck.conf.erb"),
    require => Package["logcheck"],
    owner => root,
    group => logcheck,
  }

  # create auto-puppet files
  file { [
      "/etc/logcheck/cracking.ignore.d/auto-puppet",
      "/etc/logcheck/ignore.d.paranoid/auto-puppet",
      "/etc/logcheck/ignore.d.server/auto-puppet",
      "/etc/logcheck/ignore.d.workstation/auto-puppet",
      "/etc/logcheck/violations.ignore.d/auto-puppet"
    ]:
    ensure => present,
    mode => 0644,
    owner => root,
    group => logcheck,
  }
}
