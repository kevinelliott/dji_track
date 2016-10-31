class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_order, only: [:show]

  def index
    @merchants = Merchant.active.order(created_at: :asc).includes(:orders)
    @merchant_orders = {}
    @merchants.each do |merchant|
      @merchant_orders[merchant.id] = merchant.orders.order(order_time: :asc)
    end
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    merchant = if order_params[:merchant].present?
      if order_params[:merchant].to_i > 0
        Merchant.find(order_params[:merchant].to_i)
      else
        merchant_name = order_params[:merchant].presence || 'DJI'
        Merchant.where('LOWER(name) LIKE ?', merchant_name.downcase).first
      end
    else
      Merchant.find(1)
    end

    @order = Order.find_or_initialize_by(order_id: order_params[:order_id], phone_tail: order_params[:phone_tail])
    @order.merchant              = merchant
    @order.dji_username          = order_params[:dji_username] if order_params[:dji_username].present?
    @order.email_address         = order_params[:email_address] if order_params[:email_address].present?
    @order.order_time            = DateTime.parse order_params[:order_time] if order_params[:order_time].present?
    @order.payment_status        = order_params[:payment_status] if order_params[:payment_status].present?
    @order.phone_tail            = order_params[:phone_tail] if order_params[:phone_tail].present?
    @order.shipping_city         = order_params[:shipping_city] if order_params[:shipping_city].present?
    @order.shipping_region_code  = order_params[:shipping_region_code] if order_params[:shipping_region_code].present?
    @order.shipping_postal_code  = order_params[:shipping_postal_code] if order_params[:shipping_postal_code].present?
    @order.shipping_country      = order_params[:shipping_country] if order_params[:shipping_country].present?
    @order.shipping_country_code = order_params[:shipping_country_code] if order_params[:shipping_country_code].present?
    @order.shipping_status       = order_params[:shipping_status] if order_params[:shipping_status].present?
    @order.shipping_company      = order_params[:shipping_company] if order_params[:shipping_company].present?
    @order.tracking_number       = order_params[:tracking_number] if order_params[:tracking_number].present?
    if @order.changes.present?
      # Notify user of any changes if their email address is on file
      @order.last_changed_at = Time.zone.now
    end
    @order.updated_at            = Time.zone.now

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: 'Your entry was submitted. Others will appreciate this. Thank you!' }
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
