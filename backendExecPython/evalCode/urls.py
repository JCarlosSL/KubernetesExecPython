from django.urls import path, include
from .views import EvalCodeAPIView
urlpatterns = [
    path('', EvalCodeAPIView.as_view(), name='Eval Code'),
]