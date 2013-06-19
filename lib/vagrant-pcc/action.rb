require "vagrant/action/builder"

module VagrantPlugins
  module Pcc
    module Action
      action_root = Pathname.new(File.expand_path("../action", __FILE__))
      autoload :Cleanup, action_root.join("cleanup")

      def self.cleanup
        Vagrant::Action::Builder.new.tap do |b|
          b.use Cleanup
        end
      end

    end # Action
  end # Pcc
end # VagrantPlugins
