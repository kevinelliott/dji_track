class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_order, only: [:show]

  def index
    @orders = Order.order(order_time: :asc)
  end

  def show
  end

  def create
    @order = Order.find_or_initialize_by(order_id: order_params[:order_id])
    @order.merchant              = order_params[:merchant]
    @order.order_time            = DateTime.parse order_params[:order_time] if order_params[:order_time].present?
    @order.payment_status        = order_params[:payment_status]
    @order.shipping_city         = order_params[:shipping_city]
    @order.shipping_region_code  = order_params[:shipping_region_code]
    @order.shipping_postal_code  = order_params[:shipping_postal_code]
    @order.shipping_country      = order_params[:shipping_country]
    @order.shipping_country_code = order_params[:shipping_country_code]
    @order.shipping_status       = order_params[:shipping_status]
    @order.shipping_company      = order_params[:shipping_company]
    @order.email_address         = order_params[:email_address]
    @order.dji_username          = order_params[:dji_username]
    if @order.changes.present?
      # Notify user of any changes if their email address is on file
      @order.last_changed_at = Time.zone.now
    end
    @order.updated_at            = Time.zone.now

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:merchant, :order_id, :order_time, :payment_status, :payment_method, :payment_total, :shipping_address, :shipping_address_line_2, :shipping_city, :shipping_region_code, :shipping_postal_code, :shipping_country, :shipping_country_code, :shipping_phone, :shipping_status, :shipping_company, :tracking_number, :email_address, :dji_username, :phone_tail)
    end
end
