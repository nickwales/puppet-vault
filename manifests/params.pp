# == Class vault::params
#
# This class is meant to be called from vault.
# It sets variables according to platform.
#
class vault::params {
  $user         = 'vault'
  $group        = 'vault'
  $bin_dir      = '/usr/local/bin'
  $config_dir   = '/etc/vault'
  $service_name = 'vault'

  case $operatingsystem {
    'CentOS': {
      if $operatingsystemmajrelease == '7' {
        $service_provider = 'systemd'
      } 
      else { 
        $service_provider = 'upstart' }
      }
    default: { $service_provider = 'upstart' }
  }
}
