#!/bin/bash
BRANCH=$1 
REPO=$2 # "xxxx-dev/xxxx-app"
TARGET=$3 # "xxxx/production/main"

function banner() {
  cat <<EOF
#  _  _ _ ____ _  _ ___ _    _   _    ___  ____ ___  _    ____ _   _
#  |\ | | | __ |__|  |  |     \_/     |  \ |___ |__] |    |  |  \_/
#  | \| | |__] |  |  |  |___   |      |__/ |___ |    |___ |__|   |
#
#   sleep and deploy 
#   v0.1.0
#
#   
EOF
echo "Will be waiting for $TIME and then merge and deploy $BRANCH"
}

function last_build_number(){
  echo `drone build ls --branch master $REPO|head -1|cut -d '#' -f2`
}

function last_build_status(){
  echo `drone build ls --branch master $REPO|sed -n 2p|cut -d ' ' -f2`
}


function wait_for_build_to_be_done(){
  while :
  do
    if [ "$(last_build_status)" = "success" ]; then
      drone build info $REPO $(last_build_number)
      echo "YAY! buiid is done for $BRANCH"
      break
    fi
    echo "build is not there yet for $BRANCH, lets wait 5 minute ..."
    drone build info $REPO $(last_build_number)
    sleep 5m
  done
}

function deploy() {
  echo "Going to deploy merged $BRANCH to $TARGET"
  drone build promote $REPO $(last_build_number) $TARGET
}

function merge() {
  echo "Going to merge $BRANCH to master"
  gh pr merge $BRANCH -m -R $REPO
}

merge && wait_for_build_to_be_done && deploy 
