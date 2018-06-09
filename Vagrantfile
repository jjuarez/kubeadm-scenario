# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

scenario_config_file = File.expand_path('config/default.yml', __dir__)
scenario_config      = YAML.load_file(scenario_config_file)

Vagrant.configure('2') do |config|
  config.vm.define scenario_config['master']['hostname'] do |n|
    n.vm.box      = scenario_config['master']['box']
    n.vm.hostname = scenario_config['master']['hostname']
    n.vm.network :private_network, ip: scenario_config['master']['ip']

    n.vm.provider :virtualbox do |vb|
      vb.memory = '1024'
    end

    n.vm.provision :shell, path: 'provision/shell/install_base.sh'
    n.vm.provision :shell, path: 'provision/shell/install_docker.sh'
    n.vm.provision :shell, path: 'provision/shell/install_kubetools.sh'
    n.vm.provision :hosts do |p|
      p.add_host scenario_config['master']['ip'], [scenario_config['master']['hostname']]
    end
  end

  scenario_config['nodes'].each do |node|
    config.vm.define node['hostname'] do |n|
      n.vm.box      = node['box']
      n.vm.hostname = node['hostname']
      n.vm.network :private_network, ip: node['ip']

      n.vm.provider :virtualbox do |vb|
        vb.memory = '1024'
      end

      n.vm.provision :shell, path: 'provision/shell/install_base.sh'
      n.vm.provision :shell, path: 'provision/shell/install_docker.sh'
      n.vm.provision :shell, path: 'provision/shell/install_kubetools.sh'
      n.vm.provision :hosts do |p|
        p.add_host node['ip'], [node['hostname']]
      end
    end
  end
end
