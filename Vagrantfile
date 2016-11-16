# -*- mode: ruby -*-
# vi: set ft=ruby :
#

agents = ENV['PUPPET_AGENTS'] || 3


installers = Dir.entries(File.dirname(__FILE__)).select { |f| f =~ /puppet-enterprise.*.tar.gz/ }
if installers.empty?
  fail("No installer found, please place a Puppet Enterprise tgz file in the same directory as Vagrantfile")
end

installer = installers.last

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppetlabs/centos-7.0-64-nocm"
  config.vm.define 'puppet' do |master|
    master.vm.hostname = 'puppet.localdomain'
    master.vm.provider :vmware_fusion do |v|
      v.memory = 4096
    end

    master.vm.provision "shell", inline: %Q{
      service firewalld stop
      mkdir /root/pe
      tar -xv -C /root/pe --strip 1 -f /vagrant/#{installer}
      cd /root/pe
      ./puppet-enterprise-installer -y -c /vagrant/pe.conf
      /opt/puppetlabs/bin/puppet apply /vagrant/hosts.pp
      echo '*' > /etc/puppetlabs/puppet/autosign.conf
      (/opt/puppetlabs/bin/puppet agent -t ; true)
    }
      
  end
  (1..agents.to_i).each do |sec|
    config.vm.define "agent#{sec}" do |agent|
      agent.vm.hostname = "agent#{sec}.localdomain"
      agent.vm.provision "shell", inline: %Q{
        mkdir /root/pe
        tar -xv -C /root/pe --strip 1 -f /vagrant/#{installer}
        yum install -y /root/pe/packages/el-7-x86_64/puppet-agent*
        /opt/puppetlabs/bin/puppet apply /vagrant/hosts.pp
        (/opt/puppetlabs/bin/puppet agent -t ; true)
      }
    end
  end
  
end


