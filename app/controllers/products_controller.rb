class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @manufacturers  = Manufacturer.includes(:product_families, :products).order(common_name: :asc)
    @product_family = ProductFamily.where(id: params[:product_family].to_i).includes(:manufacturer, :products).first
    @products       = if @product_family.present?
      @product_family.products.order(accessory: :asc, name: :asc)
    else
      Product.order(name: :asc)
    end
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:manufacturer_id, :product_family_id, :name, :code, :accessory, :description, :logo_url, :website, :upc, :asin, :dji_store_url, :status)
    end
end
