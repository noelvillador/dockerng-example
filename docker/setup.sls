{% set ubuntu_release = salt['grains.get']('lsb_distrib_codename', 'None') %}

apt-https:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
    - refresh: True

docker-repo:
  pkgrepo.managed:
    - name: 'deb https://apt.dockerproject.org/repo ubuntu-{{ ubuntu_release }} main'
    - refresh_db: True
    - keyserver: 'hkp://p80.pool.sks-keyservers.net:80'
    - keyid: '58118E89F3A912897C070ADBF76221572C52609D'
    - require:
      - pkg: apt-https

docker-engine:
  pkg.installed:
    - require:
      - pkgrepo: docker-repo

