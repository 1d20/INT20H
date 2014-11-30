from django.db import models

class Type(models.Model):
    desc = models.CharField(max_length=50)
    name = models.CharField(max_length=30)
    attrs = models.CharField(max_length=255)
    is_editable = models.BooleanField(default=False)
    is_approved = models.BooleanField(default=False)

    def __str__(self):
        return self.__repr__()
    def __repr__(self):
        return self.name

    def get_parents(self):
        return [s.dst_type for s in self.src.filter(is_approved=True)]

    def to_json(self):
        json = {}
        json['id'] = self.pk
        json['name'] = self.name
        json['desc'] = self.desc
        json['attrs'] = self.attrs
        json['is_editable'] = self.is_editable
        json['is_approved'] = self.is_approved

        json['child_types'] = []
        for s in self.dst.all():
            if s.src_type.is_approved:
                json['child_types'].append(s.src_type.pk)

        json['parent_types'] = []
        for s in self.src.all():
            if s.dst_type.is_approved:
                json['parent_types'].append(s.dst_type.pk)

        return json


class Type2Type(models.Model):
    src_type = models.ForeignKey(Type, related_name="src")
    dst_type = models.ForeignKey(Type, related_name="dst")

    def __str__(self):
        return self.__repr__()
    def __repr__(self):
        return self.src_type.name + " ---> " + self.dst_type.name

    def to_json(self):


        return {'id':self.pk, 'src':self.src_type.pk, 'dst':self.dst_type.pk}

