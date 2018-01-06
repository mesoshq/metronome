# metronome
A Docker image for [Metronome](https://github.com/dcos/metronome), the DC/OS job scheduler.

## Usage

You can pass all configuration properties via environment variables, **but with `_` instead of `.` (all lowercase)**. The properties can be found at [src/main/scala/dcos/metronome/MetronomeConfig.scala](https://github.com/dcos/metronome/blob/v0.3.3/src/main/scala/dcos/metronome/MetronomeConfig.scala#L16-L49).

The current list of configuration properties is:

```
metronome.framework.name
metronome.mesos.master.url
metronome.mesos.leader.ui.url
metronome.mesos.role
metronome.mesos.user
metronome.mesos.executor.default
metronome.mesos.failover.timeout
metronome.mesos.authentication.enabled
metronome.mesos.authentication.principal
metronome.mesos.authentication.secret.file
metronome.features.enable
metronome.plugin.dir
metronome.plugin.conf
metronome.history.count
metronome.behavior.metrics
metronome.leader.election.hostname
play.server.http.port
play.server.https.port
play.server.https.keyStore.path
play.server.https.keyStore.password
metronome.akka.ask.timeout
metronome.zk.url
metronome.zk.session_timeout
metronome.zk.timeout
metronome.zk.compression.enabled
metronome.zk.compression.threshold
metronome.killtask.kill_chunk_size
metronome.killtask.kill_retry_timeout
metronome.scheduler.reconciliation.interval
metronome.scheduler.reconciliation.timeout
metronome.scheduler.store.cache
metronome.scheduler.task.launch.timeout
metronome.scheduler.task.launch.confirm.timeout
metronome.scheduler.task.env.vars.prefix
metronome.scheduler.task.lost.expunge.gc
metronome.scheduler.task.lost.expunge.initial.delay
metronome.scheduler.task.lost.expunge.interval
metronome.leader.preparation.timeout
metronome.leader.proxy.timeout
metronome.akka.actor.startup.max
```

### Start with Marathon

At minimum, you need to specify `metronome_mesos_master_url` and `metronome_zk_url` in an equivalent way as outlined below.

```
{
  "id": "/metronome",
  "cpus": 1,
  "mem": 1024,
  "disk": 0,
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "volumes": [],
    "docker": {
      "image": "mesoshq/metronome:0.3.3",
      "network": "HOST",
      "privileged": false,
      "parameters": [],
      "forcePullImage": true
    }
  },
  "env": {
    "metronome_mesos_master_url": "172.17.10.101:5050",
    "metronome_zk_url": "zk://172.17.10.101:2181/metronome"
  },
  "ports": [0],
  "healthChecks": [
    {
      "path": "/ping",
      "portIndex": 0,
      "protocol": "HTTP",
      "gracePeriodSeconds": 30,
      "intervalSeconds": 10,
      "timeoutSeconds": 3,
      "maxConsecutiveFailures": 1
    }
  ]
}
```