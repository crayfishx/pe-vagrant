## pe-vagrant

### What?

This is a vagrant setup I use to quickly spin up a Puppet Enterprise master with connected agents.  It uses the vagrant-hosts gem to sync hosts files across agents and the master

### Requirements

* Currently only works for the Virtualbox Fusion provider (PR wecome)
* A Puppet Enterprise (EL7) tar.gz file placed in the same folder as Vagrantfile (tested with 2016.4)
* Lots of ram and kick-ass fans.

### Usage

Make sure you have the dependencies

```
git clone https://github.com/crayfishx/pe-vagrant
cd pe-vagrant
cp /path/to/enterprise/puppet-enterprise-2016.4.2-el-7-x86_64.tar.gz .
bundle install
```

For a PE master with three connected Puppet agents;

```
vagrant up
```

To change the number of PE agents;

```
export PUPPET_AGENTS=5
vagrant up
```

To tear it all down;
```
vagrant destroy
```



