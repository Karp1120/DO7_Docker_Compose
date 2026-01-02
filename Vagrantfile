Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/focal64"
  config.vm.box_check_update = false
  config.vm.provision "shell", path: "src/install_docker.sh"

  config.vm.define "manager01" do |manager|
    manager.vm.hostname = "manager01"
    manager.vm.network "private_network", ip: "192.168.56.10"

    manager.vm.network "forwarded_port", guest: 8081, host: 8081, auto_correct: true
    manager.vm.network "forwarded_port", guest: 8087, host: 8087, auto_correct: true
    manager.vm.network "forwarded_port", guest: 9443, host: 9443, auto_correct: true

    manager.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 4
      vb.name = "manager01"
    end

    manager.vm.provision "shell", path: "src/swarm_init.sh"
  end

  config.vm.define "worker01" do |worker|
    worker.vm.hostname = "worker01"
    worker.vm.network "private_network", ip: "192.168.56.21"
    worker.vm.boot_timeout = 600 

    worker.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 3
      vb.name = "worker01"
    end

    worker.vm.provision "shell",
      path: "src/swarm_join_worker.sh",
      args: ["192.168.56.10"]
  end

  config.vm.define "worker02" do |worker|
    worker.vm.hostname = "worker02"
    worker.vm.network "private_network", ip: "192.168.56.22"
    worker.vm.boot_timeout = 600 

    worker.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 3
      vb.name = "worker02"
    end

    worker.vm.provision "shell",
      path: "src/swarm_join_worker.sh",
      args: ["192.168.56.10"]
  end

end
