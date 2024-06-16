#!/usr/bin/env bash
set -e

function usage {
    echo "usage: entrypoint.sh [--process|--help]"
}

function plotSticks {
  su -c "Rscript /r/plotSticks.R" $USER
}

if [ "$1" != "" ]; then
    case $1 in
        -p | --process )  plotSticks
                          exit
                          ;;
        -h | --help )     usage
                          exit
                          ;;
    esac
    shift
fi

exec "$@"
