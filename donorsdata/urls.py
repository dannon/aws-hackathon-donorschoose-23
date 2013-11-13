from django.conf.urls import patterns, include, url
from django.conf import settings
from django.conf.urls.static import static

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    url(r'^$', 'donorsdata.views.index'),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^htsql/', include('htsql_django.urls')),
) + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
