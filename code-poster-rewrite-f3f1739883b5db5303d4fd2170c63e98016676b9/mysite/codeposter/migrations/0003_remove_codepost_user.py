# Generated by Django 2.0.2 on 2018-02-15 10:47

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('codeposter', '0002_codepost_user'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='codepost',
            name='user',
        ),
    ]