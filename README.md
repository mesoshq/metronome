# metronome
A Docker image (with build process) for dcos/metronome

## Usage

You can pass all configuration properties via environment variables, but with `_` instead of `.` (all lowercase). The properties can be found at [src/main/scala/dcos/metronome/MetronomeConfig.scala](https://github.com/dcos/metronome/blob/master/src/main/scala/dcos/metronome/MetronomeConfig.scala#L16-L49).

### Start with Marathon

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
      "image": "mesoshq/metronome",
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