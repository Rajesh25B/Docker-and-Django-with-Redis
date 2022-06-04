from django.shortcuts import render
from rest_framework.response import Response

from django.conf import settings

from core.tasks import add, get, update, remove
from core.cache import getallkeys, getKey

from django.http import HttpResponse
from rest_framework import viewsets, status

# Create your views here.


class TaskViewSet(viewsets.ViewSet):
    def get(self, request):
        data = get()
        return Response(data)

    def add(self, request):
        data = add(request)
        return Response(data)

    def update(self, request, pk):
        data = update(request, pk)
        return Response(data)

    def remove(self, request, pk):
        data = remove(request, pk)
        return Response(data)

    def getcache(self, request, key='*'):
        return Response(getallkeys(key))

    def getKey(self, request, key="*"):
        return Response(getKey(key))
