# == Class vault::config
#
# This class is called from vault for service config.
#
class vault::config (
    $advertise_addr   = $::vault::params::advertise_addr,
    $service_provider = $::vault::params::service_provider,
    $path             = $::vault::params::path,
    $tags             = $::vault::params::tags,
    $tls_key_file     = $::vault::params::tls_key_file,
    $tls_cert_file    = $::vault::params::tls_cert_file
){

  include datadog_agent
  include datadog_agent::integrations::consul

  file { $::vault::config_dir:
    ensure  => directory,
    purge   => $::vault::purge_config_dir,
    recurse => $::vault::purge_config_dir,
  } ->

  file { "${::vault::config_dir}/config.json":
    mode    => '0444',
    owner   => 'root',
    group   => 'root',
    content => template('vault/vault.json.erb'),
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
