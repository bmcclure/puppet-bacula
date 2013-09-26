# Define bacula::storage::device
# 
# Used to create devices in the storage manager
# 
define bacula::storage::device (
  $media_type = '',
  $archive_device = '',
  $label_media = 'yes',
  $random_access = 'yes',
  $automatic_mount = 'yes',
  $removable_media = 'no' ,
  $always_open = false,
  $template = 'bacula/device.conf.erb'
) {

  include bacula

  file { "device-${name}.conf":
    ensure  => $bacula::manage_file,
    path    => "${storage_configs_dir}/device-${name}.conf",
    mode    => $bacula::config_file_mode,
    owner   => $bacula::config_file_owner,
    group   => $bacula::config_file_group,
    require => Package[$bacula::storage_package],
    notify  => $bacula::manage_service_autorestart,
    content => template($template),
    replace => $bacula::manage_file_replace,
    audit   => $bacula::manage_audit,
  }
}