class ProductFamiliesController < ApplicationController
  before_action :set_product_family, only: [:show, :edit, :update, :destroy]

  # GET /product_families
  # GET /product_families.json
  def index
    @product_families = ProductFamily.all
  end

  # GET /product_families/1
  # GET /product_families/1.json
  def show
  end

  # GET /product_families/new
  def new
    @product_family = ProductFamily.new
  end

  # GET /product_families/1/edit
  def edit
  end

  # POST /product_families
  # POST /product_families.json
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

  # PATCH/PUT /product_families/1
  # PATCH/PUT /product_families/1.json
  def update
    respond_to do |format|
      if @product_family.update(product_family_params)
        format.html { redirect_to @product_family, notice: 'Product family was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_family }
      else
        format.html { render :edit }
        format.json { render json: @product_family.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_families/1
  # DELETE /product_families/1.json
  def destroy
    @product_family.destroy
    respond_to do |format|
      format.html { redirect_to product_families_url, notice: 'Product family was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_family
      @product_family = ProductFamily.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_family_params
      params.require(:product_family).permit(:manufacturer_id, :name, :description, :logo_url, :website, :status)
    end
end
