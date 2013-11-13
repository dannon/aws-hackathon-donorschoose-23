install-htsql-repo:
  cmd:
    - run
    - names: 
      - wget -q -O - http://dist.htsql.org/misc/build.gpg.key | apt-key add -
      - echo 'deb http://dist.htsql.org/debian stable free' >> /etc/apt/sources.list
      - apt-get update

install-packages:
  pkg:
    - installed
    - names:
      - htsql
      - htsql-pgsql
      - build-essential
      - git
      - python-dev
      - python-pip
      - nginx
    - require:
      - cmd: install-htsql-repo
  pip:
    - installed
    - name: uwsgi
    - require:
      - pkg: install-packages

nginx-config:
  cmd:
    - run
    - name: wget https://github.com/nginx/nginx/blob/master/conf/uwsgi_params
    - cwd: /etc/nginx
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://files/nginx.conf
  service:
    - enable: True
    - name: nginx
    - running

uwsgi-directory:
  file.directory:
    - name: /var/log/uwsgi

uwsgi-config:
  file.managed:
    - name: /etc/uwsgi/apps-available/donorsdata.ini
    - source: salt://files/donorsdata.ini

run-application:
  cmd.run:
    - name: uwsgi --ini /etc/uwsgi/apps-available/donorsdata.ini --chmod-socket=666


