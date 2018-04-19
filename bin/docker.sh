#!/usr/bin/env bash

# README.md###Command Environment Variables
CWD=$(dirname $(perl -MCwd -e 'print Cwd::abs_path shift' ${0}))
. ${CWD}/.helpers/init.sh

start() {
    echo -e "\n\033[1;34mStarting containers with IP address: ${IP_ADDRESS}\033[0m"
    __docker_compose pull
    __docker_compose up -d
}

stop() {
    __docker_compose down "${@}"
}

restart() {
    stop
    start
}


status() {
    __docker_compose ps
}

logs() {
    __docker_compose logs --follow --tail=200 "${@}"
}

displayHelp() {
    echo ""
    echo "This is a helper command to ease access to Docker within this project."
    echo "These are mostly wrappers around multiple docker-compose calls, but"
    echo "you can also use it to easily call the docker-compose bin without having"
    echo "to pass all the parameters required to properly access this project's"
    echo "services."
    echo ""
    echo "Usage:"
    echo "  sh ${0} start"
    echo "  sh ${0} stop"
    echo "  sh ${0} --help"
    echo ""
    echo "Options:"
    echo "  -h, --help          Print this help message."
    echo ""
    echo "Commands:"
    echo "  logs                Displays logs from each container. Maximum of 200 lines."
    echo "  restart             Restarts all the containers or a specific one"
    echo "  start               Starts the project (essentially ups the web service"
    echo "                      after pulling containers)"
    echo "  status              Displays the container status (docker-compose ps)"
    echo "  stop                Stops all the running containers when no parameter"
    echo "                      is passed or a specific container when specified"
    echo ""

    exit 0
}

case $# in
  0) displayHelp;;
esac

case $1 in
  --help|-h) displayHelp;;
  start) shift; start;;
  stop) shift; stop "${@}";;
  status) shift; status;;
  logs) shift; logs "${@}";;
  restart) shift; restart "${@}";;
  *) __docker_compose "${@}";;
esac