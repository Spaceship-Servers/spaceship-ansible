#!/usr/bin/env bash

# Helper functions
source script/helpers.sh

# Script
info "Updating all gameservers"
ansible-playbook -i inventory/gameservers playbooks/apt-autosweep.yml playbooks/apt-upgrade-all.yml --diff