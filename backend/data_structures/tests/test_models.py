"""Testing Models"""
import pytest

from data_structures.models import Category, DataStructure, Content, Algorithm


@pytest.mark.django_db
def test_category_create():
    movie = Category(name="Data Structures")
    movie.save()
    first = Category.objects.first()
    assert Category.objects.count() == 1
    assert first.name == movie.name


@pytest.mark.django_db
def test_data_structure_create():
    md = Content(name="Linked List", content="some content")
    category = Category(name="Data Structures")
    category.save()
    md.save()
    ds = DataStructure(name="Linked List", markdown_content=md, category=category,)
    ds.save()

    ds_from_db = DataStructure.objects.first()
    assert DataStructure.objects.count() == 1
    assert ds_from_db.name == ds.name
    assert ds_from_db.markdown_content == md
    assert ds_from_db.category == category


@pytest.mark.django_db
def test_content_create():
    content = Content(name="Linked List", content="some content")
    content.save()
    from_db = Content.objects.first()

    assert Content.objects.count() == 1
    assert from_db.name == content.name
    assert from_db.content == content.content


@pytest.mark.django_db
def test_algorithm_create():
    md = Content(name="Linked List", content="some content")
    md.save()
    category = Category(name="Data Structures")
    category.save()
    ds = DataStructure(name="Linked List", markdown_content=md, category=category,)
    ds.save()

    algorithm = Algorithm(
        name="Linked List Algorithm",
        category=category,
        markdown_content=md,
        data_structure=ds,
    )
    algorithm.save()
    from_db = Algorithm.objects.first()
    assert Algorithm.objects.count() == 1
    assert from_db.name == algorithm.name
    assert from_db.category == algorithm.category
    assert from_db.markdown_content == algorithm.markdown_content
    assert from_db.data_structure == algorithm.data_structure
