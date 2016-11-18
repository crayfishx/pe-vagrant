# -*- mode: ruby -*-
# vi: set ft=ruby :
#

agents = ENV['PUPPET_AGENTS'] || 3


installers = Dir.entries(File.dirname(__FILE__)).select { |f| f =~ /puppet-enterprise.*.tar.gz/ }
if installers.empty?
  fail("No installer found, please place a Puppet Enterprise tgz file in the same directory as Vagrantfile")
end

installer = installers.last
network = ENV['PE_VAGRANT_NETWORK'] || '192.168.100'
console_port = ENV['PE_VAGRANT_CONSOLE_PORT'] || '8443'

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  config.vm.define 'puppet' do |master|
    master.vm.network :private_network, ip: "#{network}.99"
    master.vm.network "forwarded_port", guest: 443, host: console_port
    master.vm.hostname = 'puppet.localdomain'
    master.vm.provider :virtualbox do |v|
      v.memory = 4096
    end

    master.vm.provision :hosts, :sync_hosts => true
    master.vm.provision "shell", inline: %Q{
      service firewalld stop
      mkdir /root/pe
      tar -xv -C /root/pe --strip 1 -f /vagrant/#{installer}
      cd /root/pe
      ./puppet-enterprise-installer -y -c /vagrant/pe.conf
      echo '*' > /etc/puppetlabs/puppet/autosign.conf
      (/opt/puppetlabs/bin/puppet agent -t ; true)
    }
      
  end
  (1..agents.to_i).each do |sec|
    config.vm.define "agent#{sec}" do |agent|
      agent.vm.hostname = "agent#{sec}.localdomain"
      agent.vm.network :private_network, ip: "#{network}.1#{sec}"
      agent.vm.provision :hosts, :sync_hosts => true
      agent.vm.provision "shell", inline: %Q{
        mkdir /root/pe
        tar -xv -C /root/pe --strip 1 -f /vagrant/#{installer}
        yum install -y /root/pe/packages/el-7-x86_64/puppet-agent*
        (/opt/puppetlabs/bin/puppet agent -t ; true)
      }
    end
  end
  
end


