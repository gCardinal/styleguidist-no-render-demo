#!/usr/bin/env bash

# README.md###Command Environment Variables
CWD=$(dirname $(perl -MCwd -e 'print Cwd::abs_path shift' ${0}))
. ${CWD}/.helpers/init.sh

BC_JS="${CWD}/../docroot/modules/custom/cogeco_bundle_calculator/js"

prod() {
    __docker_compose run ${DOCKER_USER_IDS} --rm --entrypoint node node //app/config/webpack/scripts/build.js
}

dev() {
    echo "App will be accessible at http://localhost:8001/"
    __docker_compose run -e STANDALONE=true --rm -p 8001:3000 --entrypoint node node //app/config/webpack/scripts/start.js
}

displayHelp() {
    echo ""
    echo "Build commands concerning webpack (to build and dev the React portion of this project)"
    echo ""
    echo "Usage:"
    echo "  sh ${0} compile"
    echo "  sh ${0} dev"
    echo "  sh ${0} --help"
    echo ""
    echo "Options:"
    echo "  -h, --help          Print this help message."
    echo ""
    echo "Commands:"
    echo "  dev                 Starts a webpack-dev-server"
    echo "  compile             Compiles the project to a production-ready bundle"
    echo "  tag                 Tags the most recent compiled bundle-calculator"
    echo ""

    exit 0
}

case $# in
  0) displayHelp;;
esac

case $1 in
  --help|-h) displayHelp;;
  compile) shift; prod;;
  dev) shift; dev;;
  tag) shift; tag "$*";;
  *) displayHelp;;
esac
