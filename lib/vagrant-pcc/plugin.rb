begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant Pcc plugin must be run within Vagrant."
end

# This is a sanity check to make sure no one is attempting to install
# this into an early Vagrant version.
if Vagrant::VERSION < "1.2.0"
  raise "The Vagrant Pcc plugin is only compatible with Vagrant 1.2+"
end

module VagrantPlugins
  module Pcc
    class Plugin < Vagrant.plugin("2")
      name "Pcc"
      description <<-DESC
      This plugin is intended to clean a guests certificate from a puppet
      ca server.
      DESC

      action_hook(:vagrant_pcc_cleanup, :machine_action_destroy) do |hook|
        hook.before(Vagrant::Action::Builtin::DestroyConfirm, VagrantPlugins::Pcc::Action.cleanup)
      end
    end # Plugin
  end # Pcc
end # VagrantPlugins
