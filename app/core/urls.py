from django.urls import path

from core.views import TaskViewSet

urlpatterns = [
    path(
        "tasks/",
        TaskViewSet.as_view(
            {
                "get": "get",
                "post": "add",
            }
        ),
    ),
    path("taskcache/<str:key>/", TaskViewSet.as_view({"get": "getcache"})),
    path("getkey/<str:key>/", TaskViewSet.as_view({"get": "getKey"})),
]
