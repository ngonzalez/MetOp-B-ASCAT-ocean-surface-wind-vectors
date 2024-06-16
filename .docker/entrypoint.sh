#!/usr/bin/env bash
set -e

function usage {
    echo "usage: entrypoint.sh [--process|--help]"
}

declare -a StringArray=(
  "co_conc"    "dust"       "nh3_conc"   "nmvoc_conc" "no2_conc"   "no_conc"    "o3_conc"    "pans_conc"
  "pm10_conc"  "pm2p5_conc" "pmwf_conc"  "sia_conc"   "so2_conc"
)

function displayData {
  for val in ${StringArray[@]}; do
    su -c "Rscript /r/displayData.R $val" $USER
  done
}

if [ "$1" != "" ]; then
    case $1 in
        -p | --process )  displayData
                          exit
                          ;;
        -h | --help )     usage
                          exit
                          ;;
    esac
    shift
fi

exec "$@"
