module VagrantPlugins
  module GuestLinux
    class Plugin < Vagrant.plugin("2")
      guest_capability("linux", "change_host_name") { Cap::ChangeHostName }
      guest_capability("linux", "configure_networks") { Cap::ConfigureNetworks }
    end
  end
end

Vagrant.configure(2) do |config|
  config.vm.define "triggermesh-barge"

  config.vm.box = "ailispaw/barge"
#  config.vm.base_mac = "auto"

  config.vm.hostname = "triggermesh-barge.netoneusa.com"

  config.vm.synced_folder ".", "/vagrant", id: "vagrant"

  config.vm.network :forwarded_port, guest: 8080, host: 8080
end