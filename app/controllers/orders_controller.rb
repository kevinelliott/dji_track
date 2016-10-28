class OrdersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_order, only: [:show]

  def index
    @orders = Order.all
  end

  def show
  end

  def create
    @order = Order.find_or_initialize_by(order_id: order_params[:order_id]) do |o|
      o.order_time            = DateTime.parse order_params[:order_time] if order_params[:order_time].present?
      o.payment_status        = order_params[:payment_status]
      o.shipping_city         = order_params[:shipping_city]
      o.shipping_region_code  = order_params[:shipping_region_code]
      o.shipping_postal_code  = order_params[:shipping_postal_code]
      o.shipping_country      = order_params[:shipping_country]
      o.shipping_country_code = order_params[:shipping_country_code]
      o.shipping_status       = order_params[:shipping_status]
      o.shipping_company      = order_params[:shipping_company]
      o.email_address         = order_params[:email_address]
    end
    @order.last_changed_at = Time.zone.now if @order.changes.present?
    @order.updated_at = Time.zone.now

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
      params.require(:order).permit(:order_id, :order_time, :payment_status, :payment_method, :payment_total, :shipping_address, :shipping_address_line_2, :shipping_city, :shipping_region_code, :shipping_postal_code, :shipping_country, :shipping_country_code, :shipping_phone, :shipping_status, :shipping_company, :tracking_number, :email_address)
    end
end
