from django.db import models

class Type(models.Model):
    desc = models.CharField(max_length=50)
    name = models.CharField(max_length=30)
    attrs = models.CharField()
    is_editable = models.BooleanField(default=False)
    is_approved = models.BooleanField(default=False)


class Type2Type(models.Model):
    src_type = models.ForeignKey(Type)
    dst_type = models.ForeignKey(Type)
