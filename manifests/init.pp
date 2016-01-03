class logcheck(
  $logcheck_tmp = '/tmp',
  $logcheck_addtag='no',
  $logcheck_attacksubj='Attack Alerts',
  $logcheck_date='$(date +\'%Y-%m-%d %H:%M\')',
  $logcheck_eventsubj='System Events',
  $logcheck_fqdn='1',
  $logcheck_intro='1',
  $logcheck_mailto='root',
  $logcheck_report_lvl='server',
  $logcheck_ruledir='/etc/logcheck',
  $logcheck_securitysubj='Security Events',
  $logcheck_sortuniq='0',
  $logcheck_support_cracking_ignore='0',
  $logcheck_syslogsummary='0',
  $install_database=true,
) {
  # install package
  package { "logcheck":
    ensure => present,
  }

  if $install_database {
    package { "logcheck-database":
      ensure => present,
    }
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
