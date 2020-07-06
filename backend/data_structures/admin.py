from django.contrib import admin
from .models import (
    Category,
    Content,
    DataStructure,
    Algorithm,
    AnimationFile,
)


@admin.register(AnimationFile)
class AnimationFileAdmin(admin.ModelAdmin):
    """Admin model for animation field"""


class AnimationFileInline(admin.StackedInline):
    """Animation file inline panel"""

    model = AnimationFile
    extra = 1


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    """Admin model for category"""


@admin.register(Content)
class ContentAdmin(admin.ModelAdmin):
    """Content admin class"""

    inlines = [
        AnimationFileInline,
    ]


class DataStructureContentInline(admin.StackedInline):
    """Content  inline panel"""

    model = DataStructure.contents.through
    extra = 1


class AlgorithmContentInline(admin.StackedInline):
    """Content  inline panel"""

    model = Algorithm.contents.through
    extra = 1


@admin.register(DataStructure)
class DataStructureAdmin(admin.ModelAdmin):
    """Data Structure Admin class"""

    inlines = [DataStructureContentInline]


@admin.register(Algorithm)
class AlgorithmAdmin(admin.ModelAdmin):
    """Algorithm Structure Admin class"""

    inlines = [AlgorithmContentInline]
