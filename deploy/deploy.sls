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

nginx-directories-present:
  file:
    - directory
    - names:
      - /var/log/uwsgi

uwsgi-params:
  cmd:
    - run
    - name: wget https://github.com/nginx/nginx/blob/master/conf/uwsgi_params
    - cwd: /etc/nginx

nginx-config:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://files/nginx.conf

uwsgi-config
  file.managed:
    - name: /etc/uwsgi/apps-available/donorsdata.ini
    - source: salt://files/donorsdata.ini
