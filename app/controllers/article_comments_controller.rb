class ArticleCommentsController < ApplicationController
  #update文を追加する
  def edit
    @comment = ArticleComment.find(params[:id])
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

  private

  def comment_params
    params.require(:article_comment).permit(:comment)
  end
end
