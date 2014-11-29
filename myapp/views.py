from django.shortcuts import render
from django.http import HttpResponse
from django.core import serializers

from models import *

def type_all(request):
    types = Type.objects.all()
    json = serializers.serialize('json', types)
    return HttpResponse(json)

def type_add(request):
    newtype = Type();
    newtype.desc = request.POST[desc]
    newtype.name = request.POST[name]
    newtype.attrs = request.POST[attrs]
    newtype.save()

    return HttpResponse('done')

def type_by_id(request, pk):
    try:
        requested_type = Type.objects.get(pk=int(pk))
    except Type.DoesNotExist:
        return HttpResponse('not found')
    json = serializers.serialize('json', requested_type)
    return HttpResponse(json)
