from django.db import models

class Type(models.Model):
    desc = models.CharField(max_length=50)
    name = models.CharField(max_length=30)
    attrs = models.CharField(max_length=255)
    is_editable = models.BooleanField(default=False)
    is_approved = models.BooleanField(default=False)


class Type2Type(models.Model):
    src_type = models.ForeignKey(Type, related_name="src")
    dst_type = models.ForeignKey(Type, related_name="dst")
