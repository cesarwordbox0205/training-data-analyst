#!/bin/bash -e

for container in $(ls -d */ | sed 's%/%%g'); do
  #cd $container
  if [ $container = "deploycmle" ]
  then
      cd $container
      echo "Building Docker container in $container"
      bash ../build_container.sh
      cd ..
  fi
  #bash ../build_container.sh
  #cd ..
done
