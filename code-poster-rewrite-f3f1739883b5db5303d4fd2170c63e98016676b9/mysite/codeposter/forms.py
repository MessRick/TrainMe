from django import forms
from django.forms import ModelForm
from .models import CodePost
from .models import ProgrammingLanguage


class LanguageChoiceField(forms.ModelChoiceField):
    def label_from_instance(self, obj):
        return obj.language_name


class PostCreationForm(ModelForm):
    # iquery = ProgrammingLanguage.objects.values_list('id', flat=True)
    # iquery_choices = [('', 'None')] + [(id, id) for id in iquery]
    programming_language = LanguageChoiceField(queryset=ProgrammingLanguage.objects.all())

    class Meta:
        model = CodePost
        fields = ['header', 'code', 'programming_language']
