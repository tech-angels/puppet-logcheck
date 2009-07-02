define logcheck::ignore($ensure=present, 
                        $rule,
                        $lvl='server',
                        $type='ignore') {
  case $type {
    'ignore': {
      $file = "/etc/logcheck/ignore.d.${lvl}/auto-puppet"
    }
    'violations','cracking': {
      $file = "/etc/logcheck/${type}.ignore.d/auto-puppet"
    }
    default: {
      fail "Uknown type $type for logcheck::ignore"
    }
  }
  common::concatfilepart {"set rule $name":
    file        => $file,
    content     => "$rule\n",
    ensure      => $ensure,
  }
}
