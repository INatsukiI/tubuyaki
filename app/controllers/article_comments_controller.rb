class ArticleCommentsController < ApplicationController
  def edit
    @comment = ArticleComment.find(params[:id])
    @article = Article.find(params[:article_id])
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.article_comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to article_path(@article.id)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = ArticleComment.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article.id)
  end

  def update
    @comment = ArticleComment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to article_path(@comment.article.id)
    else
      #バリデーションをつけてもう一度確認する
      render "articles/show"
    end

  end

  private

  def comment_params
    params.require(:article_comment).permit(:comment)
  end
end
