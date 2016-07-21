from django.db import models
from django.utils.translation import ugettext_lazy as _

# Create your models here.


class Boxer(models.Model):
    name = models.CharField(_('Name'), max_length=80, null=False, blank=False)
    description = models.TextField(_('Description'), null=True, blank=True)
    image = models.ImageField(_('Image'), null=True, blank=True)

    def __str__(self):
        return self.name
