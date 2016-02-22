# == Class vault::service
class vault::service (
  $service_provider = $::vault::params::service_provider  
){
  service { $::vault::service_name:
    ensure   => running,
    enable   => true,
    provider => $service_provider,
  }
}
