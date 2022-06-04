from core.models import Task
from core.serializers import TaskSerializer


def get():
    task = Task.objects.all()
    serializer = TaskSerializer(task, many=True)
    return serializer.data


def add(request):
    serializer = TaskSerializer(data=request.data)
    serializer.is_valid()
    serializer.save()
    return serializer.data


def update(request, id):
    update_task = Task.objects.get(pk=id)
    serializer = TaskSerializer(instance=update_task, data=request.data)
    serializer.is_valid()
    serializer.save()
    return serializer.data


def remove(request, pk=None):
    task = Task.objects.get(id=pk)
    task.delete()
    return "deleted"
