require "pathname"

require "vagrant-pcc/plugin"

module VagrantPlugins
  module Pcc
    lib_path = Pathname.new(File.expand_path("../vagrant-pcc", __FILE__))
    autoload :Action, lib_path.join("action")

    # This returns the path to the source of this plugin.
    #
    # @return [Pathname]
    def self.source_root
      @source_root ||= Pathname.new(File.expand_path("../../", __FILE__))
    end
  end
end
