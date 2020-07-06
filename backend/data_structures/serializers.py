from rest_framework import serializers
from .models import DataStructure, Algorithm, Category, Content, AnimationFile


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
    """Serializer class for content type info"""

    def __init__(self, *args, **kwargs):
        exclude_fields = kwargs.pop("exclude_fields", None)
        super().__init__(*args, **kwargs)

        if exclude_fields:
            for field_name in exclude_fields:
                self.fields.pop(field_name)

    animations = AnimationFileSerializer(many=True, read_only=True)

    class Meta:
        model = Content
        fields = (
            "text",
            "media_type",
            "order_of_content",
            "visual",
            "name",
            "animations",
        )


class DataStructureSerializer(serializers.ModelSerializer):
    """Serializer class for transforming DataStructure objects to JSON"""

    contents = serializers.SerializerMethodField(
        method_name="get_content", read_only=True
    )
    category = serializers.StringRelatedField(read_only=True, many=True)

    class Meta:
        model = DataStructure
        fields = ("name", "created", "contents", "category")

    def get_content(self, obj):
        qset = obj.contents.all()
        return [ContentSerializer(m, exclude_fields=["animations"]).data for m in qset]


class AlgorithmSerializer(serializers.ModelSerializer):
    """Serializer class for transforming Algorithm objects to JSON"""

    content = ContentSerializer(source="algorithm", many=True)
    data_structure = serializers.StringRelatedField(read_only=True, many=True)
    category = serializers.StringRelatedField(read_only=True, many=True)

    class Meta:
        model = Algorithm
        fields = ("name", "created", "category", "data_structure", "contents")


class CategorySerializer(serializers.ModelSerializer):
    """Serializer class for transforming Category objects to JSON"""

    class Meta:
        model = Category
        fields = ("name",)
