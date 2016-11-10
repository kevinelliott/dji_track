class TermsController < ApplicationController

  def index
    @terms = Term.all
  end

  def new
    @term = Term.new
  end

  def create
    @term = Term.new(term_params)

    respond_to do |format|
      if @term.save
        format.html { redirect_to @term, notice: 'Term was submitted and will be reviewed. Thank you!' }
        format.json { render json: @term, status: :created, location: terms_path }
      else
        format.html { render :new }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_term
      @term = Term.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def term_params
      params.require(:term).permit(:name, :description)
    end

end
