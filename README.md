# C.TF Servers - Ansible

Supported OS: Debian and Ubuntu (so far)

## Quick start guide
Install pip3 and ansible using:
```
./script/setup.sh
```

Test your installation with:
```
./script/test.sh inventory
```

Check your ssh connectivity:
```
./script/test.sh ping
```

Notice that Ansible relies on your `~/.ssh/config` file. If you can ssh to the target servers, you're good to go.

# Ansible components

## Playbooks

We have two types of playbooks: AtoZ and AdHoc.

AtoZ playbooks are located in the root of the repository. While AdHoc are located in the `playbooks/` directory.

### AtoZ

As the name implies, these playbooks provision a new server from scratch.
```
gameservers.yml:        WIP:  Installs and configure pterodactyl.
```

### AdHoc

Execute a single task over the lifetime of a server.
```
apt-autosweep.yml:      Wrapper for `apt autoclean`
apt-upgrade-all.yml:    Wrapper fot `apt update && apt upgrade`
```

## Roles

WIP: Idea is to have one main role per type of server (ie. gameservers) and then shared roles for common tasks among roles.

Main roles are located in the `roles/` directory while the shared roles are in `roles/shared/` 

## Variables

WIP: To be defined as needed.

## Handlers

WIP: To be defined as needed.

Handlers should be defined in the `handlers/<type>.yml` file which is read by the `handlers/main.yml`. The latter can be included by any playbook.

---

# STRTA

The following scripts are provided. Check their usage messages for more information.

```
./script/setup.sh:     Installs and updates pip3, ansible and ansible-lint
./script/test.sh:      Tests the inventory configuration and ssh connectivity
./script/lint.sh:      Tests the inventory configuration and ssh connectivity
---
./script/gameservers/update.sh: Runs update playbooks on all the gameservers
```
