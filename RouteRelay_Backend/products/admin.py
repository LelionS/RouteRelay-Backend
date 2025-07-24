from django.contrib import admin
from .models import Product, Category

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'description', 'created_at')
    search_fields = ('name',)

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('name', 'price', 'discount_price', 'stock', 'is_special_offer', 'category', 'created_at')
    list_filter = ('category', 'is_special_offer', 'created_at')
    search_fields = ('name', 'description')
    list_editable = ('price', 'discount_price', 'stock', 'is_special_offer')
