# Vagrant Pcc (Puppet Cert Clean)

If you run puppet agent on your vagrant nodes you create a puppet cert for communications with the puppet master.   This plugin deletes the cert associated with the vagrant node from the puppet master.

**NOTE:** This plugin requires Vagrant 1.2+,

## Installation

To use this plugin you need to have the following in your puppet master(s) auth.conf.   We only set this on a specific puppet master that supports our mostly vagrant based dev env.   Please decide for yourself wether you think this is an acceptable configuration for your environment.

 path ~ ^/certificate_status/([^/]+)$  
 auth yes  
 method find, save, destroy  
 allow $1  

 More can be read about the certificate_status endpoint here
 http://docs.puppetlabs.com/guides/rest_api.html  

The actual plugin is installed in the typical vagrant fashion  

  $ vagrant plugin install vagrant-butcher  

## Usage

If you have the plugin installed it will be executed when ever you run
  $ vagrant destroy

When the cleanup script runs on the vagrant vm it gets the following information from the local puppet installation
* certname
* ssldir
* ca_server

This information will only be available if you are running the puppet agent and have configured /etc/puppet/puppet.conf.

The plugin will always exit with a zero regardless if it was able to get the required information to locate the ca_server and ssldir.

## Todo

### Add support for the puppet_server provisioner
The puppet_server provisioner does not setup the puppet.conf file which is required to determine where ca_server and ssldir are.  
* Set the ca_server value puppet.puppet_server
* Set a sensible default for ssldir 

### Add config options
For people that are not running puppet the same way we are they may get value from the plugin if it offered a way to configure the ca_server and ssldir via the Vagrantfile.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
