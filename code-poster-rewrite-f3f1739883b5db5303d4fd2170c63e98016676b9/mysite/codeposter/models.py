from django.db import models
from django.contrib.auth.models import User
from django.urls import reverse


# Create your models here.


class ProgrammingLanguage(models.Model):
    language_name = models.CharField(max_length=50)

    def get_absolute_url(self):
        return reverse('codeposter:index')


class CodePost(models.Model):
    header = models.CharField(max_length=50)
    code = models.TextField()
    programming_language = models.ForeignKey(ProgrammingLanguage, on_delete=models.CASCADE)

    def get_absolute_url(self):
        return reverse('codeposter:index')
