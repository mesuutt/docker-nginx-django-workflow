from django.contrib import admin

from .models import Boxer


class BoxerAdmin(admin.ModelAdmin):
    pass

admin.site.register(Boxer, BoxerAdmin)
