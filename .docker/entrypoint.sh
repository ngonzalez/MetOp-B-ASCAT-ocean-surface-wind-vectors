#!/usr/bin/env bash
set -e

function usage {
    echo "usage: entrypoint.sh [--process|--help]"
}

declare -a StringArray=(
  "wind_speed"
)

function plotSticks {
  for val in ${StringArray[@]}; do
    su -c "Rscript /r/plotSticks.R $val" $USER
  done
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
