class ArticlesController < ApplicationController
  def index
    @article = Article.new
    @articles = Article.all
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.save
      flash[:notice] = "You have created book successfully."
      redirect_to articles_path
    else
      render :index
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:content)
  end
end
