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

# Debug mode
${debug} && { VERBOSE="-v"; }
debug "Running on debug mode"

# Fun begins here ↓
if ! which ansible-lint &>/dev/null; then
    error "ansible-lint is not installed, run the setup script first"
    echo "./script/setup"
    exit 1
fi

info "Running ansible-lint using our own custom rules"
ansible-lint ${VERBOSE} --exclude=~/.ansible/
[[ $? -eq 0 ]] && ok "linting successfull" || error "linting failted"
