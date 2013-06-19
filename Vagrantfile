#$:.unshift File.join(File.dirname(__FILE__), *%w[lib])
require_relative 'lib/vagrant-pcc'
Vagrant.require_plugin "vagrant-pcc"

Vagrant.configure("2") do |config|
    config.vm.box = "centos63-jive-v2"
    config.vm.hostname = "vagrant-pcc-plugin"
    config.vm.provision :shell, :inline => "echo foo > /vagrant/test"
#    config.pupclean.server = "taco"
end
