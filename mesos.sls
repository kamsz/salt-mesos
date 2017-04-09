add-mesosphere-repository:
  pkgrepo.managed:
    - name: deb http://repos.mesosphere.io/ubuntu {{ grains.get('oscodename') }} main
    - file: /etc/apt/sources.list.d/mesosphere.list
    - keyid: E56151BF
    - keyserver: keyserver.ubuntu.com

install-mesos:
  pkg.installed:
    - refresh: true
    - pkgs:
      - mesos
    - require:
      - add-mesosphere-repository

/etc/mesos/zk:
  file.managed:
    - source: salt://files/zk
    - template: jinja
