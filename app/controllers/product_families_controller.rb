class ProductFamiliesController < ApplicationController
  before_action :set_product_family, only: [:show, :edit, :update, :destroy]

  def index
    @product_families = ProductFamily.all
  end

  def show
  end

  def new
    @product_family = ProductFamily.new
  end

  def create
    @product_family = ProductFamily.new(product_family_params)

    respond_to do |format|
      if @product_family.save
        format.html { redirect_to @product_family, notice: 'Product family was successfully created.' }
        format.json { render :show, status: :created, location: @product_family }
      else
        format.html { render :new }
        format.json { render json: @product_family.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_family
      @product_family = ProductFamily.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_family_params
      params.require(:product_family).permit(:manufacturer_id, :product_family_id, :name, :description, :logo_url, :website, :status)
    end
end
