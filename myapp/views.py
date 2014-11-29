from django.shortcuts import render
from django.http import HttpResponse
from json import dumps as to_json
from models import *

def type_all(request):
    types = Type.objects.all()
    json = to_json([t.to_json() for t in types])
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
        requested_type = Type.objects.get(pk=pk)
    except Type.DoesNotExist:
        return HttpResponse('not found')
    json = to_json(requested_type.to_json())
    return HttpResponse(json)
