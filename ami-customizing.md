## Packages installed on an Ubuntu 12.04 LTS ami (ami-69f5a900)

The AMI ID is `ami-934b6efa`


`apt-get install python-pip git nginx`

`pip install django, HTSQL-MYSQL, HTSQL-DJANGO`

Need to remove the 'login required' decorator in `htsql_django/views.py` for the `gateway` method

From [the HTSQL download page](http://htsql.org/download/)

```bash
wget -q -O - http://dist.htsql.org/misc/build.gpg.key | apt-key add -
echo 'deb http://dist.htsql.org/debian stable free' >> /etc/apt/sources.list
apt-get update
apt-get install htsql
# to get Postgres support:
apt-get install htsql-pgsql
```


## Post-AMI installations / customizations
`apt-get install build-essential python-dev`

`pip install uwsgi`

mkdir -p /var/log/uwsgi


```
[uwsgi]
chdir=/root/git-repos/4Roses
module=donorsdata.wsgi:application
master=True
pidfile=/tmp/project-master.pid
vacuum=True
max-requests=5000
daemonize=/var/log/uwsgi/donorsdata.log
http = 0.0.0.0:8080
```

`wget https://github.com/nginx/nginx/blob/master/conf/uwsgi_params` into /etc/nginx/.

Some notes stolen from the HTSQL download page: http://htsql.org/download/
