#!/usr/bin/env bash

# Helper functions
source script/helpers.sh

# Functions
usage(){
    echo "Usage: ./script/setup inventory|ping (environment)"
    echo "  inventory|inv: Tests the inventory"
    echo "  ping: Ansible SSH ping"
    echo "  ---"
    echo "  (environment): Optionally specify an environment, defaults to gameservers"

    exit 1
}

# Input checking
if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
    error "Must pass one or two arguments"
    usage
fi

# Input parsing
COMMAND=${1}
ENVIRONMENT=${2:-gameservers}
ENVIRONMENT=${ENVIRONMENT%.*}
# ${INVENTORY} is the path to the corresponding inventory folder
# We do this replacement so `gameservers`, `gameservers.yml` and `inventory/gameservers` are valid inputs 
INVENTORY="inventory/${ENVIRONMENT/inventory\//}"

if [[ ! -d ${INVENTORY} ]]; then
    error "Inventory ${ENVIRONMENT} does not exist"
    exit 1
fi

# Fun begins here ↓
case "${COMMAND}" in
    "") usage ;;
    inventory|inv)
        info "Testing inventory"
        ansible-inventory -i ${INVENTORY} --graph
        ;;
    ping)
        info "Running ansible-ping"
        ansible-playbook -i ${INVENTORY} playbooks/ping.yml
        ;;
    *)
        error "Unknown command ${COMMAND}!"
        usage
        ;;
esac
