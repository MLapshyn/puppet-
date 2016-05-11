class deploy {
  remote_file::file{'/tmp/testweb.zip':
     remote_location => 'http://www.cumulogic.com/download/Apps/testweb.zip',
     mode            => '0655',
     owner           => 'root',
     group           => 'root',
   }
  
  exec {"unzip_testweb":
    command =>"/usr/bin/unzip /tmp/testweb.zip -d /opt/jboss/server/default/deploy",
    creates => "/opt/jboss/server/default/deploy/testweb",
    subscribe => Remote_file::File["/tmp/testweb.zip"],
  }
  
  file { "/opt/jboss/server/default/deploy/testweb/":
           ensure => directory,
           recurse => true,
           owner => "jboss",
           group => "jboss",
           mode => 0755,
           require => Exec['unzip_testweb'],
  }

   file { "/opt/jboss/server/default/deploy/testweb/testweb.war":
           ensure => file,
           recurse => true,
           owner => "jboss",
           group => "jboss",
           mode => 0644,
           require => Exec['unzip_testweb'],
  }
  
   file { "/opt/jboss/server/default/deploy/testweb/testweb.xml":
           ensure => file,
           recurse => true,
           owner => "jboss",
           group => "jboss",
           mode => 0644,
           require => Exec['unzip_testweb'],
  }
 
}
