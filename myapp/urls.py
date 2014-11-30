from django.conf.urls import patterns, include, url

from views import *

urlpatterns = patterns('',

    url(r'^type/$', type_all),
    url(r'^type/add$', type_add),
    url(r'^type/(?P<pk>\d+)/$', type_by_id),

    url(r'^seed/$', seed_nodes),

    url(r'^label/(?P<label>\w+)/$', node_by_label),
    url(r'^node/add$', node_add),
    url(r'^node/(?P<pk>\d+)/$', node_by_id),
    url(r'^node/(?P<pk>\d+)/like/$', node_like),
    url(r'^node/top/$', node_top),
    url(r'^node/top/(?P<count>\d+)/$', node_top),
)
