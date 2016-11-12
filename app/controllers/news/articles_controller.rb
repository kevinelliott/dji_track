class News::ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  def index
    @articles = Article.order(published_at: :desc)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to news_root_path, notice: 'Article was submitted and will be reviewed by the editor. Thank you!' }
        format.json { render :show, status: :created, location: news_article_path(article) }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :published_at, :status)
    end
end
