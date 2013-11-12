## Packages installed on an Ubuntu 12.04 LTS ami (ami-69f5a900)

The AMI ID is `ami-934b6efa`


`apt-get install python-pip git`

`pip install django, HTSQL-MYSQL, HTSQL-DJANGO`

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

Some notes stolen from the HTSQL download page: http://htsql.org/download/
