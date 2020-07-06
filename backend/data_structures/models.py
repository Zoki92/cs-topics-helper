from django.db import models
from django.db.models.constraints import UniqueConstraint
from django.db.models import Q


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

    contents = models.ManyToManyField("Content", related_name="data_structure")

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

    contents = models.ManyToManyField("Content", related_name="algorithm",)

    category = models.ForeignKey(
        "Category",
        on_delete=models.DO_NOTHING,
        blank=True,
        null=True,
        related_name="algorithms",
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


class Content(models.Model):
    """Visual representation class that sorts media about
    the algorithm/data structure, provides visual representation
    """

    class Meta:
        verbose_name_plural = "Contents"

    class MediaType(models.TextChoices):
        """Enum consisting of content type descriptors"""

        GIF = "gif"
        IMG = "img"
        VIDEO = "video"
        CODE = "code"
        TEXT = "text"

    order_of_content = models.PositiveIntegerField()

    media_type = models.CharField(
        choices=MediaType.choices, max_length=50, null=True, blank=True
    )

    name = models.CharField(max_length=50)

    visual = models.FileField(upload_to="uploads", blank=True, null=True)

    text = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.text}"


class AnimationFile(models.Model):
    """Animation files for algorithms"""

    class Meta:
        verbose_name_plural = "Animations"

    media_type = models.CharField(max_length=50, default="rive-animation")

    content = models.ForeignKey(
        "Content", on_delete=models.DO_NOTHING, related_name="animations",
    )

    animation_file = models.FileField(upload_to="uploads", blank=True, null=True)
