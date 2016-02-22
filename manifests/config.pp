# == Class vault::config
#
# This class is called from vault for service config.
#
class vault::config (
    $service_provider = $::vault::params::service_provider
){
  file { $::vault::config_dir:
    ensure  => directory,
    purge   => $::vault::purge_config_dir,
    recurse => $::vault::purge_config_dir,
  } ->
  file { "${::vault::config_dir}/config.json":
    content => vault_sorted_json($::vault::config_hash),
  }
  
notify {"What is my service provider? ${service_provider}": }


  if $service_provider == 'upstart' { 
    file { '/etc/init/vault.conf':
      mode    => '0444',
      owner   => 'root',
      group   => 'root',
      content => template('vault/vault.upstart.erb'),
    }
  }
}
