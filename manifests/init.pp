class logcheck(
  $logcheck_tmp = '/tmp'
) {
  # install package
  package { "logcheck":
    ensure => present,
  }

  # config
  file {"/etc/logcheck/logcheck.conf":
    ensure => present,
    content => template("logcheck/logcheck.conf.${lsbdistcodename}.erb"),
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
    require => Package["logcheck"],
  }
}
