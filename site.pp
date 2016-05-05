#NGINX
node default {
          notify { "Starting":}
          package { 'nginx':
          ensure => latest
  }
#SERVICE START
          service { 'nginx':
          ensure => running,
          enable => true,
          require => Package['nginx']
  }
#MYSQL
class mysql {
          root_password  => 'strongpassword',
  }
#MYSLQ DATABASE
mysql_database { 'prod_mdb':
          ensure  => present,
          charset => 'utf8',
  }
#MYSQL USER
mysql_user { 'prod_user@localhost':
          ensure => present,
              }
#USER PRIVILEGES
mysql_grant { 'prod_user@localhost/my_mdb.*':
          ensure               => present,
          options          => ['GRANT'],
          privileges   => ['ALL'],
          table    => 'prod_mdb*',
          user => 'prod_user@localhost',
            }  
}

