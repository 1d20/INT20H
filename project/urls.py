from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.views.generic.base import RedirectView
import settings
from views import *

admin.autodiscover()

urlpatterns = patterns('',
    url(r'^$', 'django.contrib.staticfiles.views.serve', kwargs={'path': 'index.html', 'document_root': settings.STATIC_ROOT}),
    url(r'^.*$', RedirectView.as_view(url='/', permanent=False), name='index'),

    url(r'^', include('myapp.urls')),
    url(r'^admin/', include(admin.site.urls)),

    url(r'^api/profile/$', profile),
    url(r'^api/logout/$', logout),
    url(r'^api/complete/(?P<backend>[^/]+)/$', AuthComplete.as_view()),
    url(r'^api/login-error/$', LoginError.as_view()),
    url(r'^api/', include('social_auth.urls')),


)
