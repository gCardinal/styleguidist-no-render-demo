#!/usr/bin/env bash

CWD=$(dirname $(perl -MCwd -e 'print Cwd::abs_path shift' ${0}))
. ${CWD}/.helpers/init.sh

__docker_compose run ${DOCKER_USER_IDS} --rm --entrypoint yarn node $*