class VideosController < ApplicationController
  before_action :set_video, only: [:show]

  def index
    @videos = Video.published.order(published_at: :desc)
  end

  def show
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.url.present?
      video_info = VideoInfo.new(@video.url)
      if video_info.available?
        @video.title        = video_info.title
        @video.description  = video_info.description
        @video.channel_name = video_info.author
        @video.channel_url  = video_info.author_url
      end
    end

    respond_to do |format|
      if @video.save
        format.html { redirect_to videos_path, notice: 'Your video submission was received and will be reviewed before publishing. Thank you!' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:streaming_site_id, :title, :summary, :description, :url, :channel_name, :channel_url, :user_id, :status)
    end
end
