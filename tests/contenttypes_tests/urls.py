from __future__ import unicode_literals

from django.conf.urls import patterns

urlpatterns = patterns('',
    (r'^shortcut/(\d+)/(.*)/$', 'django.contrib.contenttypes.views.shortcut'),
)
