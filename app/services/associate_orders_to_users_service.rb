# Connect existing users to their preexisting DJI Orders
class AssociateOrdersToUsersService
  def call
    User.all.each do |user|
      orders = Order.where(email_address: user.email)
      orders.update_all(owner_id: user.id)
    end
  end
end
