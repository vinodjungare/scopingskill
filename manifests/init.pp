# Class: scopingskill
# ===========================
#
# Full description of class scopingskill here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'scopingskill':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class scopingskill  ( $firstname = $scopingskill::params::firstname ) inherits scopingskill::params {


 # Taking value from top scope.
  notify { "Value of myname from top scope : ${myname} " : }

  # Reassigning value in local scope taking value from params class.
  $myname = $firstname

  # Next access of "myname" will give local scope value.
  notify { " New value for myname - ${myname} " : }

  # Accessing "myname" from top scope using qualified name
  notify { "Hello from top scope - ${::myname}" : }

  # Accessing a node scope variable "mylastname"
  notify { "Hello from node scope : ${mylastname}" : }

define monitor_diskspace ($logdirpath = '/tmp/diskspacelog/' , $minute = '00') {

  file { 'dir_store' :
    path => $logdirpath ,
    ensure => directory,
    owner => 'root',
    group => 'root',
}

  file { 'disk_space_script' :
    path => '/tmp/monitor_disk_space.sh',
    ensure => file,
    source => 'puppet:///modules/scoping_exercise/monitor_disk_space.sh',
    mode => '0755',
    owner => 'shyam',
    group => 'root',
}

   cron { 'hourly_diskspacelog' :
    command => '/tmp/monitor_disk_space.sh',
    minute => $minute,
}

}
