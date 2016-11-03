json.extract! article, :id, :subject, :body, :published_at, :status, :created_at, :updated_at
json.url article_url(article, format: :json)