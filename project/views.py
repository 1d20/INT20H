from django.core.urlresolvers import reverse
from django.contrib import messages
from django.contrib.auth import logout as auth_logout
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse, HttpResponseRedirect
from django.template import RequestContext
from django.shortcuts import render_to_response, redirect
from django.views.generic.base import View
from social_auth.views import complete
from social_auth import __version__ as version


def home(request):
    return render_to_response('index.html')

@login_required
def profile(request):
    ctx = {
        'version': version,
        'last_login': request.session.get('social_auth_last_login_backend')
    }
    return render_to_response('done.html', ctx, RequestContext(request))

def logout(request):
    """Logs out user"""
    auth_logout(request)
    return HttpResponseRedirect('/')

class AuthComplete(View):
    def get(self, request, *args, **kwargs):
        backend = kwargs.pop('backend')
        try:
            return complete(request, backend, *args, **kwargs)
        except Exception:
            messages.error(request, "Your Google Apps domain isn't authorized for this app")
            return HttpResponseRedirect('/home/')

class LoginError(View):
    def get(self, request, *args, **kwargs):
        return HttpResponse(status=401)
