docker.io:
  pkg.installed

/etc/mesos-slave/ip:
  file.managed:
    - source: salt://files/myip_hostname
    - template: jinja

/etc/mesos-slave/hostname:
  file.managed:
    - source: salt://files/myip_hostname
    - template: jinja

/etc/mesos-slave/containerizers:
  file.managed:
    - source: salt://files/containerizers

/etc/init/zookeeper.override:
  file.managed:
    - source: salt://files/service.override

/etc/init/mesos-master.override:
  file.managed:
    - source: salt://files/service.override

stop-and-disable-mesos-master:
  service.dead:
    - name: mesos-master
    - enable: false

stop-and-disable-zookeeper:
  service.dead:
    - name: zookeeper
    - enable: false

start-mesos-slave:
  service.running:
    - name: mesos-slave
    - enable: true
    - watch:
      - file: /etc/mesos-slave/ip
      - file: /etc/mesos-slave/hostname
      - file: /etc/mesos-slave/containerizers
