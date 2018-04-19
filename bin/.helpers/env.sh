#!/usr/bin/env bash

# Define all any environment variable in this file
# Allow it to be overridden by shell environment variables
# Example:
# export   name  | env name | default
# export VARIABLE=${VARIABLE:-default}

export IP_ADDRESS=${IP_ADDRESS:-0.0.0.0}
PROJECT_NAME=${PROJECT_NAME:-demo}
DOCKER_CWD=${DOCKER_CWD:-$(perl -MCwd -e 'print Cwd::abs_path shift' ${CWD}/../docker)}
DOCKER_CONTAINER=${DOCKER_CONTAINER:-no}
ENV_NAME=${ENV_NAME:-dev}

# If you need to change a variable specific for an OS use the following case
if [ -z ${JENKINS_HOME+x} ] && [ ${DOCKER_CONTAINER} == no ]; then
    case $(uname -s) in
        Linux)
            HOST_OS=Linux
            export IP_ADDRESS=$(ifconfig docker0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
            export DOCKER_USER_IDS="-u $(id -u):$(id -g)"
            ;;
        Darwin)
            HOST_OS=Mac
            ;;
        MINGW*|MSYS*)
            HOST_OS=Windows
            export IP_ADDRESS=$(ipconfig | grep -a7 DockerNAT | grep IPv4 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')
            ##export IP_ADDRESS=10.2.115.43
            ;;
        *)
            echo Unknown OS: $(uname -s). This needs to be fixed!
            exit 1
            ;;
    esac
fi
