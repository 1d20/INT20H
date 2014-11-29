from django.shortcuts import render
from django.http import HttpResponse

from neo_models import *


def test(request):
    jim = Person(name='Jim', age=3).save()
    jim.age = 4
    jim.save() # validation happens here
#    jim.delete()
 #   jim.refresh() # reload properties from neo

    germany = Country(code='DE').save()
    jim.country.connect(germany)

    if jim.country.is_connected(germany):
        print("Jim's from Germany")

    for p in germany.inhabitant.all():
        print(p.name) # Jim

    len(germany.inhabitant) # 1

    # Find people called 'Jim' in germany
    germany.inhabitant.search(name='Jim')

    jim.country.disconnect(germany)

    response = HttpResponse()
    response.write(str(jim))
    return response
