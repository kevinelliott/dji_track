json.extract! merchant, :id, :name, :description, :website, :referral_code, :status, :created_at, :updated_at
json.url merchant_url(merchant, format: :json)