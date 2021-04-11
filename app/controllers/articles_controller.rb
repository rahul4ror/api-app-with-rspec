class ArticlesController < ApplicationController
  def index
    articles = Article.recent.page(params[:page]).per(params[:per_page])
    render json: articles
  end

  def show
    article = Article.find(params[:id])
    render json: article
  end

  def create
    article = Article.new(article_params)
    article.save!
    render json: article, status: :created
  rescue
    render json: article, adapter: :json_api,
      serializer: ActiveModel::Serializer::ErrorSerializer,
      status: :unprocessable_entity
  end

  def update
    article = Article.find(params[:id])
    article.update!(article_params)
    render json: article, status: :ok
  rescue
    render json: article, adapter: :json_api,
      serializer: ActiveModel::Serializer::ErrorSerializer,
      status: :unprocessable_entity
  end

  private

  def article_params
    params.require(:data).require(:attributes).permit(:title, :slug, :content) || ActionController::Parameters.new
  end
end