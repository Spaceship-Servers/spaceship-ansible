#!/usr/bin/env bash

# Helper functions
source script/helpers.sh

# Input parsing
COMMAND=${1}

# Functions
usage() {
    echo "Usage: ./script/setup"
    echo "  help:    Shows this message"
    echo "  pip3:    Installs pip3 only"
    echo "  ansible: Installs/updates ansible only"
    echo "---"
    echo "  if no argument is passed, then pip3 and ansible are installed"
    exit 1
}

install_pip3() {
    if ! which pip3 &>/dev/null; then
        warn "pip3 is not installed, installing from apt"
        sudo apt install -y python3-pip
    else
        info "pip3 already installed"
    fi
}

install_ansible(){
    if ! which ansible-playbook &>/dev/null; then
        warn "Ansible is not installed, installing from pip3"
    else
        info "Ansible is installed, checking for updates"
    fi
    pip3 install --user --upgrade ansible-core ansible ansible-lint
}

if ! which apt &>/dev/null; then
    error "Linux distro not supported (yet)"
    exit 1
fi

# Fun begins here ↓
case "${COMMAND}" in
    ""|pip3)
        info "Installing/updating pip3"
        install_pip3
        ;&
    ""|ansible)
        info "Installing/updating anisble"
        install_ansible 
        ;;
    help) usage ;;
    *)
        error "Unknown command ${COMMAND}"
        usage
        ;;
esac
