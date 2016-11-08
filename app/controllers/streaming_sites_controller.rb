class StreamingSitesController < ApplicationController
  before_action :set_streaming_site, only: [:show]

  def index
    @streaming_sites = StreamingSite.all
  end

  def show
  end

  def new
    @streaming_site = StreamingSite.new
  end


  def create
    @streaming_site = StreamingSite.new(streaming_site_params)

    respond_to do |format|
      if @streaming_site.save
        format.html { redirect_to @streaming_site, notice: 'Streaming site was successfully created.' }
        format.json { render :show, status: :created, location: @streaming_site }
      else
        format.html { render :new }
        format.json { render json: @streaming_site.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_streaming_site
      @streaming_site = StreamingSite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def streaming_site_params
      params.require(:streaming_site).permit(:name, :code, :description, :website, :logo_url)
    end
end
