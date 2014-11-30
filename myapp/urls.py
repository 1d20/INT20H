from django.conf.urls import patterns, include, url

from api import *
from views import *

urlpatterns = patterns('',
    url(r'^$', apimap),

    url(r'^seed/$', seed),

    url(r'^country/$', country_all),
    url(r'^country/(?P<code>\w+)/$', country_by_code),

    url(r'^university/$', university_all),
    url(r'^university/(?P<code>\w+)/$', university_by_code),


    url(r'^type/$', type_all),
    url(r'^type/add$', type_add),
    url(r'^type/(?P<pk>\d+)/$', type_by_id),

    url(r'^type2type/$', type2type_all),
    url(r'^type2type/add$', type2type_add),
    url(r'^type2type/(?P<pk>\d+)/$', type2type_by_id),
)
