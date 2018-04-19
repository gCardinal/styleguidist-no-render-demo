#!/usr/bin/env bash

test -z ${CWD} && {
    echo This file can not be called directly!
    exit 1
}

# Source Environment variables
. ${CWD}/.helpers/env.sh

# Source functions
. ${CWD}/.helpers/docker-compose.sh
