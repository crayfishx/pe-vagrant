## pe-vagrant

### What?

This is a vagrant setup I use to quickly spin up a Puppet Enterprise master with connected agents.  It uses a hostname hack to get all the machines sharing the same /etc/hosts file so they can communicate.

### Requirements

* Currently only works for the VMWare Fusion provider (PR wecome)
* A Puppet Enterprise (EL7) tar.gz file placed in the same folder as Vagrantfile (tested with 2016.4)

### Usage

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



