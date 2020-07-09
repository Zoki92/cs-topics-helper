from django.contrib import admin
from .models import (
    Category,
    Content,
    DataStructure,
    Algorithm,
    AnimationFile,
    DataStructureMarkdown,
)

from markdownx.admin import MarkdownxModelAdmin

admin.site.register(DataStructureMarkdown, MarkdownxModelAdmin)


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


@admin.register(DataStructure)
class DataStructureAdmin(admin.ModelAdmin):
    """Data Structure Admin class"""


@admin.register(Algorithm)
class AlgorithmAdmin(admin.ModelAdmin):
    """Algorithm Structure Admin class"""
