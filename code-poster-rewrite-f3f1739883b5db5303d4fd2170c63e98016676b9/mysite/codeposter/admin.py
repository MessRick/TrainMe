from django.contrib import admin

# Register your models here.

from .models import CodePost, ProgrammingLanguage

admin.site.register(ProgrammingLanguage)
admin.site.register(CodePost)
