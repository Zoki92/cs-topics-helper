"""Testing views"""
import pytest
from django.shortcuts import reverse
from data_structures.models import Content, DataStructure, Category
from rest_framework.test import APIClient


@pytest.fixture
def api_client():
    return APIClient()


@pytest.mark.django_db
def test_valid_request(api_client):
    url = reverse("data-structure-list")
    response = api_client.get(url)
    assert response.status_code == 200


@pytest.mark.django_db
def test_getting_valid_data(api_client):
    md = Content(name="Linked List", content="some content")
    md.save()
    category = Category(name="Data Structures")
    category.save()
    ds = DataStructure(name="Linked List", markdown_content=md, category=category,)
    ds.save()
    url = reverse("data-structure-list")
    response = api_client.get(url)

    assert response.status_code == 200
    assert response.data["count"] == 1
    assert response.data["next"] is None
    assert response.data["results"][0]["markdown_content"]["content"] == md.content
    assert response.data["results"][0]["category"] == category.name
