#!/bin/bash

function read_env {
    for var in `env`
    do
      if [[ "$var" =~ ^metronome_ ]]; then
        env_var=`echo "$var" | sed -r "s/(.*)=.*/\1/g"` #extract just the env var name out of $var
        metronome_property=`echo "$env_var" | tr _ . `
        echo $metronome_property
        opts=$opts"-D$metronome_property=${!env_var} "
      fi
    done
}

read_env

# Set http port from $PORT0
opts=$opts-Dplay.server.http.port=$PORT0

echo $opts

export JAVA_OPTS=$opts

$APP_DIR/metronome-0.1.7-SNAPSHOT/bin/metronome