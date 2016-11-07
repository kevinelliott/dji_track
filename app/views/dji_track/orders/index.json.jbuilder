json.array! @merchants, partial: 'dji_track/orders/merchants' do |merchant|
  json.name merchant.name
  json.orders @merchant_orders[merchant.id], partial: 'dji_track/orders/order', as: :order
end
