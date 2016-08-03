FROM java:openjdk-8-jre

ENV BUILD_DIR /build
ENV APP_DIR /app

# Overall ENV vars
ENV MESOS_VERSION 1.0.0-2.0.89.debian81

# Add package sources and install
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    echo "deb http://repos.mesosphere.io/debian jessie main" | tee /etc/apt/sources.list.d/mesosphere.list && \
    echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
    apt-get update && \
    apt-get install --no-install-recommends -y --force-yes mesos=$MESOS_VERSION git wget sbt && \
    mkdir -p $BUILD_DIR && \
    cd $BUILD_DIR && \
    git clone https://github.com/dcos/metronome.git && \
    cd metronome && \
    sbt -Dsbt.log.format=false universal:packageBin && \
    mv $(find target/universal -name 'metronome-*-SNAPSHOT.zip' | sort | tail -1) $APP_DIR && \
    unzip $APP_DIR/*.zip && \
    rm -rf target/* ~/.sbt ~/.ivy2 && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD docker_entrypoint.sh .

ENTRYPOINT ["/docker_entrypoint.sh"]
