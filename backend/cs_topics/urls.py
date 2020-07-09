from django.contrib import admin
from django.urls import path, include, re_path
from markdownx import urls as markdownx

from django.urls import path
from rest_framework import routers

from data_structures.views import (
    DataStructuresListView,
    # AlgorithmsListView,
    # CategoryListView,
)
from django.conf import settings
from django.conf.urls.static import static

router = routers.DefaultRouter()

router.register(r"data-structures", DataStructuresListView, basename="data-structure")
# router.register(r"algorithms", AlgorithmsListView, basename="algorithm")
# router.register(r"categories", CategoryListView, basename="category")


urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/", include(router.urls)),
    re_path(r"^markdownx/", include("markdownx.urls")),
]


if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
