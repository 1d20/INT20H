from django.shortcuts import render
from django.http import HttpResponse
from json import dumps as to_json

from models import *
from neo import *

def type_all(request):
    types = Type.objects.filter(is_approved=True)
    json = to_json([t.to_json() for t in types])
    return HttpResponse(json)

def type_add(request):
    if not request.method == "POST":
        return HttpResponse('request shoud be POST, but it is %s'%str(request.method))

    newtype = Type();
    newtype.desc = request.POST['desc']
    newtype.name = request.POST['name']
    newtype.attrs = request.POST['attrs']
    newtype.save()

    newtype2type = Type2Type();
    newtype2type.src_type = newtype
    newtype2type.dst_type = Type.objects.get(pk=int(request.POST['dst']))
    newtype2type.save()

    return HttpResponse('done')

def type_by_id(request, pk):
    try:
        requested_type = Type.objects.get(pk=pk)
    except Type.DoesNotExist:
        return HttpResponse('not found')
    json = to_json(requested_type.to_json())
    return HttpResponse(json)

def type2type_all(request):
    types = Type2Type.objects.all()
    json = to_json([t.to_json() for t in types])
    return HttpResponse(json)

def type2type_add(request):
    if not request.method == "POST":
        return HttpResponse('request shoud be POST, but it is %s'%str(request.method))

    newtype2type = Type2Type();
    newtype2type.src_type = Type.objects.get(pk=int(request.POST['src']))
    newtype2type.dst_type = Type.objects.get(pk=int(request.POST['dst']))
    newtype2type.save()

    return HttpResponse('done')

def type2type_by_id(request, pk):
    try:
        requested_type = Type2Type.objects.get(pk=pk)
    except Type2Type.DoesNotExist:
        return HttpResponse('not found')
    json = to_json(requested_type.to_json())
    return HttpResponse(json)

#===========================================================================================
def seed_nodes(request):
    seed()
    return HttpResponse('done')

def node_add(request):
    if not request.method == "POST":
        return HttpResponse('request shoud be POST, but it is %s'%str(request.method))
    node_type = Type.objects.get(pk=request.POST['type'])
    values = request.POST['values']
    create(node_type, values)
    return HttpResponse('done')

def node_by_label(request, label):
    nodes = find_by_label(label)
    json = to_json(nodes)
    return HttpResponse(json)

def node_by_id(request, pk):
    node = find_by_id(pk)
    json = to_json(node)
    return HttpResponse(json)

def node_like(request, pk):
    return HttpResponse('done')
