# == Class vault::params
#
# This class is meant to be called from vault.
# It sets variables according to platform.
#
class vault::params (
  $advertise_addr = $ipaddress,
  $path           = '',
  $tags           = [],
  $tls_cert_file  = '',
  $tls_key_file   = '',
  
) {
  $user         = 'vault'
  $group        = 'vault'
  $bin_dir      = '/usr/local/sbin'
  $config_dir   = '/etc/vault.d'
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
