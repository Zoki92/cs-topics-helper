from django.test import TestCase
from ..models import Category, DataStructure


class CategoryModelTest(TestCase):
    """Category test class"""

    def test_string_representation(self):
        """testing models str representation"""
        category = Category(name="Array")
        self.assertEqual('Array', str(category))

    def test_saving_and_retrieving_categories(self):
        """testing db for category actions"""
        category = Category(name="Array")
        category.save()

        category_2 = Category(name="Stack")
        category_2.save()

        saved_items = Category.objects.all()
        self.assertEqual(saved_items.count(), 2)

        fetched_category = saved_items[0]
        fetched_category_2 = saved_items[1]

        self.assertEqual(fetched_category.name, category.name)
        self.assertEqual(fetched_category_2.name, category_2.name)


class DataStructureModelTest(TestCase):
    """DataStructure test class"""

    def test_string_representation(self):
        """testing models str representation"""
        ds = DataStructure(name="Binary Search Tree")
        self.assertEqual("Binary Search Tree", str(ds))

    def test_saving_and_retrieving_data_structures(self):
        """testing db for category actions"""
        ds = DataStructure(name="Binary Search Tree")
        ds_2 = DataStructure(name="Tree")

        ds_2.save()

        ds.save()

        all_ds = DataStructure.objects.all()

        self.assertEqual(all_ds.count(), 2)

        self.assertEqual(all_ds[0].name, ds_2.name)
        self.assertEqual(all_ds[1].name, ds.name)
