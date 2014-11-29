from django.conf.urls import patterns, include, url
from django.contrib import admin

from views import AuthComplete, LoginError, home

admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'project.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    url(r'^', include('myapp.urls')),

    url(r'^complete/(?P<backend>[^/]+)/$', AuthComplete.as_view()),
    url(r'^login-error/$', LoginError.as_view()),
    url(r'', include('social_auth.urls')),

    url(r'^home/$', home),


    url(r'^admin/', include(admin.site.urls)),
)
