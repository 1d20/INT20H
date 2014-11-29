from models import *

def seed_countries():
    try:
        ua = Country.nodes.get(code='UA')
    except Country.DoesNotExist:
        ua = Country(code='UA', name='Ukraine').save()

    try:
        ru = Country.nodes.get(code='RU')
    except Country.DoesNotExist:
        ru = Country(code='RU', name='Russian Federation').save()

    return ua, ru

def seed_universities(ua, ru):
    try:
        kpi = University.nodes.get(code='KPI')
    except University.DoesNotExist:
        kpi = University(code='KPI', name='Kiev Polytehnical Institute').save()
    if not kpi.country.is_connected(ua):
        kpi.country.connect(ua)

    try:
        mti = University.nodes.get(code='MTI')
    except University.DoesNotExist:
        mti = University(code='MTI', name='Moscow Technical Institute').save()
    if not mti.country.is_connected(ru):
        mti.country.connect(ru)

    return kpi, mti

def seed_all():
    ua, ru = seed_countries()
    kpi, mti = seed_universities(ua, ru)
