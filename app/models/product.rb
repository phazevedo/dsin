class Product < ApplicationRecord
    has_many :product_ingredients
    has_many :ingredients, :through => :product_ingredients

    as_many :order_products
    has_many :orders, :through => :order_products
end
