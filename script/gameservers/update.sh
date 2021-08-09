#!/usr/bin/env bash

# Helper functions
source script/helpers.sh

# Debug mode
${debug} && { VERBOSE="--verbose"; }
debug "Running on debug mode"

# Script
info "Updating all gameservers"
ansible-playbook -i inventory/gameservers playbooks/apt-upgrade-all.yml playbooks/apt-autosweep.yml ${VERBOSE} --diff $@