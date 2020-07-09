from django.db.models import Prefetch
from rest_framework import viewsets
from .models import DataStructure, Content, Algorithm, Category
from .serializers import (
    DataStructureSerializer,
    # AlgorithmSerializer,
    # CategorySerializer,
)


class DataStructuresListView(viewsets.ModelViewSet):
    """Api end point that returns list of data structures"""

    serializer_class = DataStructureSerializer

    def get_queryset(self):
        return DataStructure.objects.all()


# class AlgorithmsListView(viewsets.ModelViewSet):
#     """Api end point that returns list of algorithms"""

#     serializer_class = AlgorithmSerializer

#     def get_queryset(self):
#         return Algorithm.objects.all()


# class CategoryListView(viewsets.ModelViewSet):
#     """Api end point that returns list of categories"""

#     serializer_class = CategorySerializer

#     def get_queryset(self):
#         return Category.objects.all()
