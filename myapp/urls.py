from django.conf.urls import patterns, include, url
from views import *

urlpatterns = patterns('',

    url(r'^test/', test),

    url(r'api/', include('myapp.api_urls'))
)
