from django.urls import path

from . import views
app_name = 'codeposter'

urlpatterns = [
    path('', views.IndexView.as_view(), name='index'),
    path('create_post', views.CreatePost.as_view(), name='create_post'),
    path('add_programming_language', views.AddProgrammingLanguage.as_view(), name='add_programming_language')
]