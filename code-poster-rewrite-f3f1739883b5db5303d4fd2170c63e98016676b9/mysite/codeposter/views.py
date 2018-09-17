from django.shortcuts import render
from .models import CodePost
from .models import ProgrammingLanguage
from .forms import PostCreationForm
from django.views.generic import ListView
from django.views.generic import FormView
from django.views.generic import CreateView
from django.views.generic import UpdateView
from django.views.generic import DeleteView
from django.views.generic import DetailView


# Create your views here.

class IndexView(ListView):
    model = CodePost
    template_name = 'codeposter/index.html'
    context_object_name = 'posts'

    def get_queryset(self):
        return CodePost.objects.all()


class CreatePost(CreateView):
    model = CodePost
    form_class = PostCreationForm
    template_name = 'codeposter/create_post.html'


class AddProgrammingLanguage(CreateView):
    model = ProgrammingLanguage
    template_name = 'codeposter/add_programming_language.html'
    fields = ['language_name']
