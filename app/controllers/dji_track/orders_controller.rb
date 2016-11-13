class DjiTrack::OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_order, only: [:show, :history]

  SORTABLE_COLUMNS = %w(order_id dji_username order_time shipping_country payment_status shipping_company shipping_status delivery_status last_changed_at updated_at)
  
  def index
    @merchants = Merchant.active.order(created_at: :asc).includes(:orders)
    @merchant_orders = {}
    @merchants.each do |merchant|
      sort_column = SORTABLE_COLUMNS.include?(params[:sort_column]) ? params[:sort_column] : 'order_time'
      sort_order  = %w(asc desc).include?(params[:sort_order]) ? params[:sort_order] : 'asc'
      sort        = "#{sort_column} #{sort_order.upcase}"

      @merchant_orders[merchant.id] = merchant.orders.order(sort)
    end

    @average_duration = begin
      deliveries = []
      @merchant_orders.each do |merchant, orders|
        orders.each do |order|
          deliveries << order.delivered_in_days if order.delivered_in_days.present?
        end
      end
      if deliveries.count > 0
        puts "Deliveries: #{deliveries.count}, Deliveries Sum: #{deliveries.sum.to_f}"
        puts "Days #{(deliveries.sum.to_f / deliveries.count)}, Weeks: #{((deliveries.sum.to_f / deliveries.count) / 7).round(1)}"
        "#{((deliveries.sum.to_f / deliveries.count) / 7).round(1)} weeks"
      end
    end

    @orders_by_country = {}
    @countries = Order.select(:shipping_country).uniq
  end

  def recent
    shipped = OrderStateLog.where('order_state_logs.column = ? AND LOWER(order_state_logs.to) = ?', 'shipping_status', 'shipped')
    @order_state_logs = shipped.order(created_at: :desc).to_a.group_by_day(&:created_at)

    last_12_hours = shipped.where('order_state_logs.created_at >= ?', 12.hours.ago.in_time_zone('UTC')).count
    last_24_hours = shipped.where('order_state_logs.created_at >= ?', 24.hours.ago.in_time_zone('UTC')).count

    @shipping_state, @shipping_state_count = if last_12_hours > 0
      [:active, last_12_hours]
    elsif last_24_hours > 0
      [:slow, last_24_hours]
    else
      [:stopped, 0]
    end

  end

  def show
  end

  def new
    @order = Order.new
    @shipping_companies = shipping_companies
  end

  def create
    @shipping_companies = shipping_companies

    merchant = if order_params[:merchant].present?
      if order_params[:merchant].to_i > 0
        Merchant.find(order_params[:merchant].to_i)
      else
        merchant_name = order_params[:merchant].presence || 'DJI'
        Merchant.where('LOWER(common_name) LIKE ?', merchant_name.downcase).first
      end
    else
      Merchant.find(1)
    end

    @order = Order.find_or_initialize_by(order_id: order_params[:order_id], phone_tail: order_params[:phone_tail])
    @order.merchant              = merchant
    @order.product               = Product.find(order_params[:product_id]) if order_params[:product_id].present?
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
      changes = @order.changes
      @order.last_changed_at = Time.zone.now
    end
    @order.updated_at            = Time.zone.now

    respond_to do |format|
      if @order.save
        OrderStateLog.track_changes(@order, changes) if changes.present?

        format.html { redirect_to dji_track_orders_path, notice: 'Your entry was submitted. Others will appreciate this. Thank you!' }
        format.json { render json: @order, status: :created, location: dji_track_orders_path }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def chart_data
    render json: Order.where(order_time: [Date.parse('2016-09-27')..Date.parse('2016-10-11')]).group(:shipping_status).group_by_day(:order_time).count.chart_json
  end

  def history
    protected_columns = %w(order_id shipping_address shipping_address_line_2 shipping_city shipping_phone phone_tail tracking_number email_address)
    @state_logs = @order.order_state_logs.where('order_state_logs.column NOT IN (?)', protected_columns).order(created_at: :desc).reject

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def country_chart_data
    render json: Order.group(:shipping_country).order('count_id desc').limit(15).count(:id).chart_json
  end

  def order_month_chart_data
    render json: Order.group_by_month(:order_time, format: '%B').count.chart_json
  end

  def recently_shipped_chart_data
    last_7_days = [1.week.ago.in_time_zone('UTC').to_date..Date.today]

    shipped = OrderStateLog.where('order_state_logs.column = ? AND LOWER(order_state_logs.to) = ?', 'shipping_status', 'shipped')
    @osls = shipped.group_by_day(:created_at, last: 14).count

    render json: @osls.chart_json
  end

  def order_time_chart_data
    render json: Order.group_by_day(:order_time).count.chart_json
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:merchant, :order_id, :order_time, :payment_status, :payment_method, :payment_total, :shipping_address, :shipping_address_line_2, :shipping_city, :shipping_region_code, :shipping_postal_code, :shipping_country, :shipping_country_code, :shipping_phone, :shipping_status, :shipping_company, :tracking_number, :email_address, :product_id, :dji_username, :phone_tail)
    end

    def shipping_companies
      [
        ['Pending', 'Tba'],
        ['DHL', 'Dhl'],
        ['FedEx', 'Fedex'],
        ['Sagawa', 'Sagawa'],
        ['UPS', 'Ups']
      ]
    end

end
