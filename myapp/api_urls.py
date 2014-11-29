from django.conf.urls import patterns, include, url
from api import *

urlpatterns = patterns('',
    url(r'^$', apimap),

    url(r'^seed/$', seed),

    url(r'^country/$', country_all),
    url(r'^country/(?P<code>\w+)/$', country_by_code),

    url(r'^university/$', university_all),
    url(r'^university/(?P<code>\w+)/$', university_by_code),



)
