from django.db import models
from django.db.models.constraints import UniqueConstraint
from django.db.models import Q
from markdownx.models import MarkdownxField


class Category(models.Model):
    """Category model class"""

    class Meta:
        verbose_name_plural = "Categories"

    name = models.CharField(max_length=50)
    created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.name}"


class DataStructure(models.Model):
    """Data structure model class"""

    class Meta:
        verbose_name_plural = "Data Structures"

    name = models.CharField(max_length=50)

    markdown_content = models.OneToOneField(
        "Content", on_delete=models.PROTECT, blank=True, null=True,
    )

    category = models.ForeignKey(
        "Category", on_delete=models.DO_NOTHING, blank=True, null=True,
    )

    created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.name}"


class Algorithm(models.Model):
    """Algorithm model class"""

    class Meta:
        verbose_name_plural = "Algorithms"

    name = models.CharField(max_length=50)

    category = models.ForeignKey(
        "Category",
        on_delete=models.DO_NOTHING,
        blank=True,
        null=True,
        related_name="algorithms",
    )
    markdown_content = models.OneToOneField(
        "Content", on_delete=models.PROTECT, blank=True, null=True,
    )

    created = models.DateTimeField(auto_now_add=True)

    data_structure = models.ForeignKey(
        "DataStructure",
        on_delete=models.DO_NOTHING,
        blank=True,
        null=True,
        related_name="algorithms",
    )

    def __str__(self):
        return f"{self.name}"


class AnimationFile(models.Model):
    """Animation files for algorithms"""

    class Meta:
        verbose_name_plural = "Animations"

    media_type = models.CharField(max_length=50, default="rive-animation")

    content = models.ForeignKey(
        "Algorithm", on_delete=models.DO_NOTHING, related_name="animations",
    )

    animation_file = models.FileField(upload_to="uploads", blank=True, null=True)


class Content(models.Model):
    """Model for creating datastructure markdown objects"""

    class Meta:
        verbose_name_plural = "Data Structure Markdowns"

    name = models.CharField(max_length=255, null=True, blank=True)

    content = MarkdownxField()

    def __str__(self):
        return f"{self.name}"
