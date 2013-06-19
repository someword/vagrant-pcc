require 'FileUtils'
module VagrantPlugins
  module Pcc
    module Action
      class Cleanup

        def initialize(app,env)
          @app = app
        end

        def using_puppet?(env)
          env[:machine].config.vm.provisioners.find do |p|
            p.config.is_a? VagrantPlugins::Puppet::Config
            p.config.is_a? VagrantPlugins::Shell::Config
          end
        end

        def setup(env)
          clean_script = 'puppet-cert-clean'
          script_dir = File.join(Pcc.source_root, 'bin')
          dst = "#{env[:machine].env.root_path}/puppet-cert-clean"
          src = "#{script_dir}/#{clean_script}"

          unless File.exists?(dst)
            FileUtils.cp(src, dst)
            FileUtils.chmod(0755, dst)
          end
        end

        def call(env)
          #if using_puppet?(env)
          if true
            setup(env)
            # How do I verify that '/vagrant' is available in the guest
            # config.vm.synced_folder ".", "/vagrant"
            command =  "/vagrant/puppet-cert-clean"
            if env[:machine].state.id != :running
              env[:ui].info("#{ machine.name} is not running.") 
            end 
            env[:machine].communicate.sudo(command) do | type, data | 
              env[:ui].info(data) 
            end
          end
            
          @app.call(env)
        end

      end # Cleanup
    end # Action
  end # Pcc
end # VagrantPlugins
