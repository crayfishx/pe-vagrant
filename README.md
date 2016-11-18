## pe-vagrant

### What?

This is a vagrant setup I use to quickly spin up a Puppet Enterprise master with connected agents.  It uses the vagrant-hosts plugin to sync hosts files across agents and the master

It's a little rough around the edges right now as it's something that's organically grown over time and I've only ever used this in my own personal sand box environment, feel free to submit improvements!

### Requirements

* Vagrant (tested with 1.8.7)
* Virtualbox (tested with 5.1.8)
* A Puppet Enterprise (EL7) tar.gz file placed in the same folder as Vagrantfile (tested with 2016.4)
* Lots of ram and kick-ass fans.

### Usage

Make sure you have the dependencies

```
git clone https://github.com/crayfishx/pe-vagrant
cd pe-vagrant
cp /path/to/enterprise/puppet-enterprise-2016.4.2-el-7-x86_64.tar.gz .
vagrant plugin install vagrant-hosts
```

For a PE master with three connected Puppet agents;

```
vagrant up
```

You can then access the PE console at `https://localhost:8443`.  The username is `admin` and the admin password (as defined in pe.conf) is `puppetlabs`

To change the number of PE agents;

```
export PUPPET_AGENTS=5
vagrant up
```

To tear it all down;
```
vagrant destroy
```

### Ports

Unless overridden with the `PE_VAGRANT_CONSOLE_PORT`, `PE_VAGRANT_ORCHESTRATION_PORT`or `PE_VAGRANT_RBAC_PORT` environment variables, the following is available on the host machine:

* The console is accessable as `https://localhost:8443`
* The RBAC API (for generating tokens..etc) is available at `https://localhost:4433/rbac-api/v1/`
* The orchestrator API is available at `https://localhost:8143/orchestrator/v1/`


### Author

Feel free to ping me with comments or questions

Craig Dunn <craig@craigdunn.org>, @crayfishx

