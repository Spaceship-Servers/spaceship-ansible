#!/usr/bin/env bash

# Helper functions
source script/helpers.sh

# Functions
usage(){
    echo "Usage: ./script/lint"
    echo "  Executes ansible-lint using our custom rules"
    exit 1
}

# Input check
[[ -n ${1} ]] && usage

# Fun begins here ↓
if ! which ansible-lint &>/dev/null; then
    error "ansible-lint is not installed, run the setup script first"
    show "./script/setup"
    exit 1
fi

info "Running ansible-lint using our own custom rules"
# This is to exclude any roles installed by ansible-galaxy from our linting process
ansible-lint --exclude=~/.ansible/
[[ $? -eq 0 ]] && ok "linting successfull" || error "linting failted"
