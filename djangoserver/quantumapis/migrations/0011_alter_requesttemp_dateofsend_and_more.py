# Generated by Django 5.0 on 2023-12-16 10:30

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('quantumapis', '0010_delete_receiver_alter_requesttemp_dateofsend_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='requesttemp',
            name='dateofsend',
            field=models.DateField(default=datetime.datetime(2023, 12, 16, 16, 0, 57, 439187)),
        ),
        migrations.AlterField(
            model_name='requesttemp',
            name='timeofsend',
            field=models.TimeField(default=datetime.datetime(2023, 12, 16, 16, 0, 57, 439187)),
        ),
    ]
