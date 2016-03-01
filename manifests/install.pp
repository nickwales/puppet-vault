# == Class vault::install
#
class vault::install (
  $tags = $vault::params::tags,
) {

  $vault_bin = "${::vault::bin_dir}/vault"

  package { 'vault':
    ensure  =>  'latest',
  } ~>
  file { $vault_bin:
    owner => 'root',
    group => 'root',
    mode  => '0555',
  }

  if !$::vault::config_hash['disable_mlock'] {
    exec { "setcap cap_ipc_lock=+ep ${vault_bin}":
      path        => ['/sbin', '/usr/sbin'],
      subscribe   => File[$vault_bin],
      refreshonly => true,
    }
  }

  user { $::vault::user:
    ensure => present,
  }
  group { $::vault::group:
    ensure => present,
  }

  include consul::service_template

  consul::service_template::service_template { "vault":
    service_name  => "vault",
    tags          => $tags,
    port          => 8200,
    check_type    => "http",
    check_command => "http://127.0.0.1:8200/v1/sys/health",
    interval      => "10s"
  }

}
