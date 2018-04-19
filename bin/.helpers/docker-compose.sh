#!/usr/bin/env bash

DOCKER_COMPOSE_FILES=${DOCKER_COMPOSE_FILES:-""}

if [[ ${ENV_NAME} = "dev" ]]; then
    DOCKER_ARGS="-f ${DOCKER_CWD}/docker-compose.yml -f ${DOCKER_CWD}/docker-compose.dev.yml -p ${PROJECT_NAME}"
else
    DOCKER_ARGS="-f ${DOCKER_CWD}/docker-compose.yml -p ${PROJECT_NAME}"
fi

# Wrapper for docker-compose that will combine some variables
# as docker-compose arguments
__docker_compose() {
    if [ $# -eq 0 ]; then
        echo "__docker_compose: called without argument(s)!"
        exit 1
    fi
    ARGS="${DOCKER_ARGS}"
    if [ "${DOCKER_COMPOSE_FILES}" != "" ]; then
        ARGS="${ARGS} -f ${DOCKER_COMPOSE_FILES// / -f }"
    fi

    echo -e "\n\033[1;34mRunning docker-compose command:\033[0m"
    echo -e "docker-compose ${ARGS} ${@}\n"

    docker-compose ${ARGS} "${@}"
}
