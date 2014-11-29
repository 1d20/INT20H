from django.conf.urls import patterns, include, url
from django.contrib import admin

from views import *

admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^blog/', include('blog.urls')),
    url(r'^', include('myapp.urls')),


    url(r'^$', home, name='home'),
    url(r'^profile/$', profile),
    url(r'^logout/$', logout, name='logout'),
    url(r'^close_login_popup/$', close_login_popup, name='login_popup_close'),

    url(r'^complete/(?P<backend>[^/]+)/$', AuthComplete.as_view()),
    url(r'^login-error/$', LoginError.as_view()),
    url(r'', include('social_auth.urls')),


    url(r'^admin/', include(admin.site.urls)),
)
