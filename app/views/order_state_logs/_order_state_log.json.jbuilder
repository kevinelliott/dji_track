json.extract! order_state_log, :id, :order_id, :column, :from, :to, :created_at, :updated_at
json.url order_state_log_url(order_state_log, format: :json)