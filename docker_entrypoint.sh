#!/bin/bash

# Function to retrieve and rename env variables starting with metronome_*
function read_env {
    for var in `env`
    do
      if [[ "$var" =~ ^metronome_ ]]; then
        env_var=`echo "$var" | sed -r "s/(.*)=.*/\1/g"`
        metronome_property=`echo "$env_var" | tr _ . `
        opts=$opts"-D$metronome_property=${!env_var} "
      fi
    done
}

# Get all interesting env variables
read_env

# Set http port from $PORT0 and set JAVA_OPTS
export JAVA_OPTS=$opts-Dplay.server.http.port=$PORT0

# Debug info
echo $JAVA_OPTS

# Start metronome
$APP_DIR/metronome-0.1.7-SNAPSHOT/bin/metronome