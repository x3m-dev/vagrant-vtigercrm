Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 1
  end

  config.vm.define "server" do |machine|
    machine.vm.box = "bento/ubuntu-20.04"
#    machine.vm.synced_folder ".", "/vagrant"
    machine.vm.network "forwarded_port", guest: 80, host: 8088
    machine.vm.provision "shell", path: "script.sh"
  end

end
