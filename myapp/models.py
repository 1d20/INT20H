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

    def to_json(self):
        return {'id':self.pk, 'name':self.name, 'desc':self.desc, 'attrs':self.attrs, 'is_editable':self.is_editable, 'is_approved':self.is_approved}


class Type2Type(models.Model):
    src_type = models.ForeignKey(Type, related_name="src")
    dst_type = models.ForeignKey(Type, related_name="dst")

    def __str__(self):
        return self.__repr__()
    def __repr__(self):
        return self.src_type.name + " ---> " + self.dst_type.name

    def to_json(self):
        return {'id':self.pk, 'src':self.src_type.pk, 'dst':self.dst_type.pk}

from py2neo import Node, Relationship

# class AbstractNode():
#     def __init__(self, node_type):
#         self.node_type = node_type
#         self.node = Node(node_type.name)

#     def save(self):



# alice = Node("Person", name="Alice")
# >>> bob = Node("Person", name="Bob")
# >>> alice_knows_bob = Relationship(alice, "KNOWS", bob)
# >>> graph.create(alice_knows_bob)
# alice.properties["age"] = 33
# >>> bob.properties["age"] = 44
# >>> alice.push()
# >>> bob.push()
