# C.TF Servers - Ansible

Supported OS: Debian and Ubuntu (so far).

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

## Usage
To provision a brand new server from scratch:

1. Make sure you can ssh as root.
1. Add the server to the inventory file.
1. `ansible-playbook gameservers.yml --limit=[name of the new server]`.
  * I recommend to use `--limit` to not make changes on any other server.

### Pro-tips
* You can execute just certain parts of a playbook using `--tags=[tag]`
  * Check the `yml` files for tag definitions, or run `ansible-playbook gameservers.yml --list-tags` to get a full list.
* You can add the flags `--diff` for a more verbose output.
* If you're getting ssh timeout errors, try reducing your number of forks on `ansible.cfg`.
* If you're getting "variable not defined errors" make sure your facts are up to date.
  1. `rm -rf /tmp/facts_cache`
  1. `ansible-playbook playbooks/gather_facts.yml`

---

# Ansible components

## Playbooks

We have two types of playbooks: AtoZ and AdHoc.

AtoZ playbooks are located in the root of the repository. While AdHoc are located in the `playbooks/` directory.

### AtoZ

As the name implies, these playbooks provision a new server from scratch.
```
gameservers.yml:        Installs and configure docker, ufw, users and pterodactyl.
```

### AdHoc

Execute a single task over the lifetime of a server.
```
apt-autosweep.yml:      Wrapper for `apt autoclean`
apt-upgrade-all.yml:    Wrapper fot `apt update && apt upgrade`
```

## Roles

Idea is to have one main role per type of server (ie. gameservers) and then shared roles for common tasks among roles.

Main roles are located in the `roles/` directory while the shared roles are in `roles/shared/` 

## Variables

WIP: To be defined as needed.

## Handlers

Handlers should be defined in the `handlers/<type>.yml` file which is read by the `handlers/main.yml`. The latter can be included by any playbook and we want all handlers to be shared everywhere.

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
