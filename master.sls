add-oracle-java-repository:
  pkgrepo.managed:
    - ppa: webupd8team/java

echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections:
  cmd.run

echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections:
  cmd.run

install-marathon:
  pkg.installed:
    - refresh: true
    - pkgs:
      - oracle-java8-installer
      - oracle-java8-set-default
      - marathon
    - require:
      - add-oracle-java-repository

/etc/zookeeper/conf/myid:
  file.managed:
    - source: salt://files/myid

/etc/zookeeper/conf/zoo.cfg:
  file.managed:
    - source: salt://files/zoo.cfg
    - template: jinja

/etc/mesos-master/ip:
  file.managed:
    - source: salt://files/myip_hostname
    - template: jinja

/etc/mesos-master/hostname:
  file.managed:
    - source: salt://files/myip_hostname
    - template: jinja

/etc/init/mesos-slave.override:
  file.managed:
    - source: salt://files/service.override

stop-and-disable-mesos-slave:
  service.dead:
    - name: mesos-slave
    - enable: false

stop-master-zookeeper:
  service.dead:
    - name: zookeeper

start-master-zookeeper:
  service.running:
    - name: zookeeper
    - enable: true
    - watch:
      - file: /etc/zookeeper/conf/myid
      - file: /etc/zookeeper/conf/zoo.cfg

start-mesos-master:
  service.running:
    - name: mesos-master
    - enable: true
    - watch:
      - file: /etc/mesos-master/ip
      - file: /etc/mesos-master/hostname

start-marathon:
  service.running:
    - name: marathon
    - enable: true
