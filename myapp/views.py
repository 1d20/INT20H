from django.shortcuts import render
from django.http import HttpResponse

from neo import Person, Pet


def test(request):
    pete = Person.objects.create(name='Pete', age=30)
    garfield = Pet.objects.create()
    pete.pets.add(garfield)
    pete.save()
    l = list(pete.pets.all())

    response = HttpResponse()
    response.write(str(l))
    return response
