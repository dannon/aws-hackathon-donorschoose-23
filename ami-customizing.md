## Packages installed on an Ubuntu 12.04 LTS ami (ami-69f5a900)

The AMI ID is `ami-934b6efa`


`apt-get install python-pip git build-essential python-dev`

`pip install django, HTSQL-MYSQL, HTSQL-DJANGO uwsgi`

From [the HTSQL download page](http://htsql.org/download/)

```bash
wget -q -O - http://dist.htsql.org/misc/build.gpg.key | apt-key add -
echo 'deb http://dist.htsql.org/debian stable free' >> /etc/apt/sources.list
apt-get update
apt-get install htsql
# to get Postgres support:
apt-get install htsql-pgsql
```


Some notes stolen from the HTSQL download page: http://htsql.org/download/
