from django.http import HttpResponse, HttpResponseRedirect
from models import *
from seeder import *
import json

def seed(request):
    seed_all()
    return HttpResponseRedirect('/api/')

def apimap(request):
    response = HttpResponse()

    response.write("<a href='seed/'>seed</a><br/><br/>")

    response.write("<a href='country/'>country all</a><br/>")
    response.write("<a href='country/UA'>country UA</a><br/><br/>")
    response.write("<a href='country/RU'>country RU</a><br/><br/>")

    response.write("<a href='university/'>university all</a><br/>")
    response.write("<a href='university/KPI'>university KPI</a><br/><br/>")
    response.write("<a href='university/MTI'>university MTI</a><br/><br/>")
    return response



def get_all(Entity):
    entities = Entity.nodes.all()
    if len(entities) == 0:
        return None
    else:
        JSON = [e.to_json() for e in entities]
        string = json.dumps(JSON)
        return HttpResponse(string)

def get_by_code(Entity, code):
    try:
        item = Entity.nodes.get(code=code.upper())
        return HttpResponse(json.dumps(item.to_full_json()))
    except Entity.DoesNotExist:
        return HttpResponse("{ 'error':'not found' }")

def country_all(request):
    return get_all(Country)

def country_by_code(request, code):
    return get_by_code(Country, code)

def university_all(request):
    return get_all(University)

def university_by_code(request, code):
    return get_by_code(University, code)
