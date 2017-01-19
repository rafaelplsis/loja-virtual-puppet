Vagrant.configure("2") do |config|
	config.vm.box = "precise32"
	
	config.librarian_puppet.puppetfile_dir = "librarian"
	
	config.vm.define :db do |db_config|
		db_config.vm.hostname = "db"	
		db_config.vm.network :private_network, :ip => "192.168.33.10"
		db_config.vm.provision "puppet" do |puppet|
			puppet.module_path = ["modules", "librarian/modules"]
			puppet.manifest_file = "db.pp"
		end
	end
	
	config.vm.define :web do |web_config|
		web_config.vm.hostname = "web"		
		web_config.vm.network :private_network, :ip => "192.168.33.12"
		web_config.vm.provision "puppet" do |puppet|
			puppet.module_path = ["modules", "librarian/modules"]
			puppet.manifest_file = "web.pp"
		end		
	end
	
	config.vm.define :monitor do |monitor_config|
		monitor_config.vm.hostname = "monitor"
		monitor_config.vm.network :private_network, :ip => "192.168.33.14"
	end	
	
	config.vm.define :ci do |build_config|
		build_config.vm.hostname = "ci"	
		build_config.vm.network :private_network,
								:ip => "192.168.33.16"
		build_config.vm.provision "puppet" do |puppet|
			puppet.module_path = ["modules","librarian/modules"]
			puppet.manifest_file = "ci.pp"
		end
	end
	
    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 2
    end	
end