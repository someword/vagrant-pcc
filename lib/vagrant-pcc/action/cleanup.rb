#require 'FileUtils'
module VagrantPlugins
  module Pcc
    module Action
      class Cleanup

        attr_accessor :guestpath

        def initialize(app,env)
          @app = app
        end

        def provisioners(name, env)
          env[:machine].config.vm.provisioners.select do |prov|
            prov.name == name 
          end
        end

        def puppet_apply?(env)
          provisioners(:puppet, env).any?
        end

        def puppet_agent?(env)
          provisioners(:puppet_server, env).any?
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

          env[:machine].config.vm.synced_folders.each do |id, data|
              @guestpath = data[:guestpath] if data[:hostpath] == "."
          end

          @guestpath ||= '/vagrant'
        end

        def call(env)
          if puppet_apply?(env) or puppet_agent?(env)
            setup(env)
            command = "#{@guestpath}/puppet-cert-clean"
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
