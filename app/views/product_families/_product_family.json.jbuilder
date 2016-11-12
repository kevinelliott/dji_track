json.extract! product_family, :id, :manufacturer_id, :name, :description, :logo_url, :website, :status, :created_at, :updated_at
json.url product_family_url(product_family, format: :json)