# Generated by Django 4.1.1 on 2022-10-24 21:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('applet', '0002_action_id_service_reaction_id_service'),
    ]

    operations = [
        migrations.AlterField(
            model_name='action',
            name='id_service',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='action',
            name='name',
            field=models.CharField(max_length=200, unique=True),
        ),
        migrations.AlterField(
            model_name='reaction',
            name='id_service',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='reaction',
            name='name',
            field=models.CharField(max_length=200, unique=True),
        ),
    ]
