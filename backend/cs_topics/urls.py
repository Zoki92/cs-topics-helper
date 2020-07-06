from django.contrib import admin
from django.urls import path, include

from django.urls import path
from rest_framework import routers
from data_structures.views import (
    DataStructuresListView,
    AlgorithmsListView,
    CategoryListView,
)

router = routers.DefaultRouter()

router.register(r"data-structures", DataStructuresListView, basename="data-structure")
router.register(r"algorithms", AlgorithmsListView, basename="algorithm")
router.register(r"categories", CategoryListView, basename="category")


urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/", include(router.urls)),
]
