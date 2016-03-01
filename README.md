# puppet-vault

Puppet module to install and run [Hashicorp Vault](https://vaultproject.io).

Installs the consul rpm according to your architecture.

## Support

This module is currently only tested on CentOS 7.x

## Usage

```puppet
include vault
```

By default, vault requires a minimal configuration including a backend and a
listener.

Servers need to be setup via hiera e.g.

---
classes: role::vault
vault::params::path: <consul_backend_path>
vault::params::tags: 
  - tag1
  - tag2
  - tag3
vault::params::tls_cert_file: ssl_cert.crt
vault::params::tls_key_file: ssl_key.key

## Consul

We use the consul::service_template defined type to create the service in consul

### mlock

By default vault will use the `mlock` system call, therefore the executable
will need the corresponding capability.

The module will use `setcap` on the vault binary to enable this.
If you do not wish to use `mlock`, then modify your `config_hash` like:

```puppet
class { '::vault':
    config_hash => {
        'disable_mlock' => true
    }
}
```
