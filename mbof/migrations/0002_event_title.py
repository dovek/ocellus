# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-07-06 14:17
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mbof', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='event',
            name='title',
            field=models.CharField(default='Untitled', max_length=50),
        ),
    ]