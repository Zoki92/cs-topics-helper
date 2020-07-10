from rest_framework import serializers
from .models import (
    DataStructure,
    Algorithm,
    Category,
    AnimationFile,
    Content,
)


class AnimationFileSerializer(serializers.ModelSerializer):
    """Serializer class for animation file model"""

    class Meta:
        model = AnimationFile
        fields = (
            "media_type",
            "content",
            "animation_file",
        )


class ContentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Content
        fields = ("name", "content")


class DataStructureSerializer(serializers.ModelSerializer):
    """Serializer class for transforming DataStructure objects to JSON"""

    markdown_content = ContentSerializer(read_only=True)
    category = serializers.StringRelatedField(read_only=True)

    class Meta:
        model = DataStructure
        fields = ("name", "created", "category", "markdown_content")


class AlgorithmSerializer(serializers.ModelSerializer):
    """Serializer class for transforming Algorithm objects to JSON"""

    content = ContentSerializer(read_only=True)
    data_structure = serializers.StringRelatedField(read_only=True)
    category = serializers.StringRelatedField(read_only=True)

    class Meta:
        model = Algorithm
        fields = ("name", "created", "category", "data_structure", "markdown_content")


class CategorySerializer(serializers.ModelSerializer):
    """Serializer class for transforming Category objects to JSON"""

    class Meta:
        model = Category
        fields = ("name",)
