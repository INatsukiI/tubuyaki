class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:edit]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.order("created_at DESC")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  #フォロー機能
  def following
    #@userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.following
    render :show
  end

  def followers
    #@userをフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.followers
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def check_user
    @user = User.find(params[:id])
      unless @user == current_user
        redirect_to articles_path
      end
  end
end
