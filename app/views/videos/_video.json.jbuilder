json.extract! video, :id, :streaming_site_id, :title, :summary, :description, :url, :channel_name, :channel_url, :user_id, :status, :created_at, :updated_at
json.url video_url(video, format: :json)