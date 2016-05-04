## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# Disable filebucket by default for all File resources:
File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  notify { "This is ${::fqdn}, running the ${::operatingsystem} operating system": }
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}

node 'learning.puppetlabs.vm' {
    include ::mysql::server::account_security
    class { '::mysql::server':
          root_password        => 'strongpassword',
              override_options => {
               'mysqld'        => { 'max_connections' => '1024' }
              }
    }
    mysql_database { 'my_mdb':
        ensure        => present,
              charset => 'utf8',
}
    mysql_user { 'my_user@localhost':
          ensure => present,
              }
              mysql_grant { 'my_user@localhost/my_mdb.*':
                    ensure               => present,
                        options          => ['GRANT'],
                            privileges   => ['ALL'],
                                table    => 'my_mdb*',
                                    user => 'my_user@localhost',
                                      }
}
