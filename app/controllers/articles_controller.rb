class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:edit]
  before_action :get_article, only: [:index]

  def index
    #@article = Article.new
    #@articles = Article.all.order("created_at DESC")
    @q = Article.ransack(params[:q])
    @articles = @q.result(distinct: true).order("created_at DESC")
  end

  def show
    @article = Article.find(params[:id])
    @comment = ArticleComment.new
    @comments = @article.article_comments
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash[:notice] = "You have created book successfully."
      redirect_to articles_path
    else
      #@articles = Article.all.order("created_at DESC")
      @q = Article.ransack(params[:q])
      @articles = @q.result(distinct: true).order("created_at DESC")
      render :index
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to articles_path
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to articles_path
    else
      render :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:content, :image)
  end

  def check_user
    @article = Article.find(params[:id])
      unless @article.user == current_user
        redirect_to articles_path
      end
  end

  def get_article
    @article = Article.new
    @articles = Article.all.order("created_at DESC")
  end
end
