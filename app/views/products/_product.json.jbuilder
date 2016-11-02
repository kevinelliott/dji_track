json.extract! product, :id, :manufacturer_id, :name, :code, :description, :logo_url, :website, :upc, :asin, :status, :created_at, :updated_at
json.url product_url(product, format: :json)