define logcheck::logfile($ensure=present, $file) {
  common::concatfilepart {"$name":
    ensure      => $ensure,
    file        => "/etc/logcheck/logcheck.logfiles",
    content     => "$file\n",
  }
}
