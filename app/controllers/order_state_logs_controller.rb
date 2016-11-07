class OrderStateLogsController < ApplicationController
  before_action :set_order_state_log, only: [:show, :edit, :update, :destroy]

  # GET /order_state_logs
  # GET /order_state_logs.json
  def index
    @order_state_logs = OrderStateLog.all
  end

  # GET /order_state_logs/1
  # GET /order_state_logs/1.json
  def show
  end

  # GET /order_state_logs/new
  def new
    @order_state_log = OrderStateLog.new
  end

  # GET /order_state_logs/1/edit
  def edit
  end

  # POST /order_state_logs
  # POST /order_state_logs.json
  def create
    @order_state_log = OrderStateLog.new(order_state_log_params)

    respond_to do |format|
      if @order_state_log.save
        format.html { redirect_to @order_state_log, notice: 'Order state log was successfully created.' }
        format.json { render :show, status: :created, location: @order_state_log }
      else
        format.html { render :new }
        format.json { render json: @order_state_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_state_logs/1
  # PATCH/PUT /order_state_logs/1.json
  def update
    respond_to do |format|
      if @order_state_log.update(order_state_log_params)
        format.html { redirect_to @order_state_log, notice: 'Order state log was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_state_log }
      else
        format.html { render :edit }
        format.json { render json: @order_state_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_state_logs/1
  # DELETE /order_state_logs/1.json
  def destroy
    @order_state_log.destroy
    respond_to do |format|
      format.html { redirect_to order_state_logs_url, notice: 'Order state log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_state_log
      @order_state_log = OrderStateLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_state_log_params
      params.require(:order_state_log).permit(:order_id, :column, :from, :to)
    end
end
