class LikesController < ApplicationController

  def create
    article = Article.find(params[:id])
    Like.create(user_id: current_user.id, article_id: article.id)
  end
  
  def destroy
    article = Article.find(params[:id])
    Like.find_by(user_id: current_user.id, article_id: article.id).destroy
  end
  
  
  
  

end
