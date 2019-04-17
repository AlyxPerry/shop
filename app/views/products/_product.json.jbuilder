json.extract! product, :id, :price, :quantity, :name, :description, :image, :brand, :category_id, :rating, :created_at, :updated_at
json.url product_url(product, format: :json)
