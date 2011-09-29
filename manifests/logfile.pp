define logcheck::logfile($ensure=present, $file) {
  common::concatfilepart {"$name":
    ensure      => $ensure,
    file        => "/etc/logcheck/logcheck.logfiles",
    manage	=> true,
    content     => "$file\n",
  }
}
