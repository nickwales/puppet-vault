# == Class vault::config
#
# This class is called from vault for service config.
#
class vault::config (
    $service_provider = $::vault::params::service_provider,
    $path             = $::vault::params::path,
    $tls_key_file     = $::vault::params::tls_key_file,
    $tls_cert_file    = $::vault::params::tls_cert_file
){
  file { $::vault::config_dir:
    ensure  => directory,
    purge   => $::vault::purge_config_dir,
    recurse => $::vault::purge_config_dir,
  } ->

  file { "${::vault::config_dir}/config.json":
    mode    => '0444',
    owner   => 'root',
    group   => 'root',
    content => template('vault.json.erb'),
  }
  
  if $service_provider == 'upstart' { 
    file { '/etc/init/vault.conf':
      mode    => '0444',
      owner   => 'root',
      group   => 'root',
      content => template('vault/vault.upstart.erb'),
    }
  }
}
