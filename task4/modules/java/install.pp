class java {
package { 'java-1.6.0-openjdk.x86_64':
     ensure => 'installed',
     before => Package['unzip'],
   }
}
