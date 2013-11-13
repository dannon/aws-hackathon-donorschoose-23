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
    - require:
      - cmd: install-htsql-repo
  pip:
    - installed
    - name: uwsgi

nginx-directories-present:
  file:
    - directory
    - names:
      - /var/log/uwsgi
      - /etc/nginx

uwsgi-params:
  cmd:
    - wait
    - name: wget https://github.com/nginx/nginx/blob/master/conf/uwsgi_params
    - cwd: /etc/nginx
    - watch:
      - file: nginx-directories-present
