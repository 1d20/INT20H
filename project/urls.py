from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.views.generic.base import RedirectView
from views import *

admin.autodiscover()

urlpatterns = patterns('',
    url(r'^$', home),

    url(r'^api/', include('myapp.urls')),
    url(r'^admin/', include(admin.site.urls)),

    url(r'^', include('social_auth.urls')),

    url(r'^profile/$', profile),
    url(r'^logout/$', logout),
    url(r'^complete/(?P<backend>[^/]+)/$', AuthComplete.as_view()),
    url(r'^login-error/$', LoginError.as_view()),

    url(r'^.*$', RedirectView.as_view(url='/', permanent=False), name='index'),
)
