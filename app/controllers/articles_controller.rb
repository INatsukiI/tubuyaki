class ArticlesController < ApplicationController
  def index
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    #@book.user_id = current_user.id

    if @article.save
      flash[:notice] = "You have created book successfully."
      redirect_to article_path
    else
      render :index
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
