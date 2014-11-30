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
from urllib import urlopen
from django.core.files import File
from svglib.svglib import svg2rlg
from reportlab.graphics import renderPDF
import os
from settings import BASE_DIR, STATIC_URL

def gen_pdf(request):
    svg_file = os.path.join(BASE_DIR, 'static') + '/file.svg'
    pdf_file = os.path.join(BASE_DIR, 'static') + '/file.pdf'

    with open(svg_file, 'w') as f:
        myfile = File(f)
        svg = request.POST['svg']
        myfile.write(svg)

    drawing = svg2rlg(svg_file)
    renderPDF.drawToFile(drawing, pdf_file)

    return HttpResponseRedirect(STATIC_URL + "file.pdf")

def home(request):
    ctx = {
        'version': version,
        'last_login': request.session.get('social_auth_last_login_backend')
    }
    return render_to_response('index.html', ctx, RequestContext(request))

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
            response = complete(request, backend, *args, **kwargs)
            if 'picture' in response:
                avatar = urlopen(url)
                image_basename = slugify(user.username + " social")
                image_name = '%s%s.jpg' % (int(time.time()), image_basename)
                user.avatar.save(image_name, ContentFile(avatar.read()))
                user.save()
            return response
        except Exception:
            messages.error(request, "Your Google Apps domain isn't authorized for this app")
            return HttpResponseRedirect('/')

class LoginError(View):
    def get(self, request, *args, **kwargs):
        return HttpResponse(status=401)
