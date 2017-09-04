xdt_file { 'C:/temp/puppet.config':
    source_file => 'C:\Development\androidbilling\AndroidBilling\Web.config',
    transform_file => 'C:\Development\androidbilling\AndroidBilling\Web.staging.config',
    ensure => present,
}