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
      - unzip
      - postgres-sql
      - postgres-sql-client
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
    - template: jinja
  service:
    - enable: True
    - name: nginx
    - running

update-nginx-config:
  cmd.run:
    - name: NAME=`curl http://169.254.169.254/latest/meta-data/public-hostname` && sed -i 's/server_name --change-me--/server_name '"$NAME"'/g' /etc/nginx/nginx.conf

uwsgi-directory:
  file.directory:
    - name: /var/log/uwsgi

uwsgi-config:
  file.managed:
    - name: /etc/uwsgi/apps-available/donorsdata.ini
    - source: salt://files/donorsdata.ini

install-application:
  cmd.run:
    - names: 
      - wget https://s3.amazonaws.com/hackathon-team-23/4Roses.zip
      - unzip 4Roses.zip -d /var/www/

build-database:
  cmd.run:
    - names: 
      - wget http://adeptium-hackathon2013.s3.amazonaws.com/donorschoose+norm.sql.gz

run-application:
  cmd.run:
    - name: uwsgi --ini /etc/uwsgi/apps-available/donorsdata.ini --chmod-socket=666


