class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:edit]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.order("created_at DESC")
    
    #Entryテーブルから検索
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @room_bool = true
            @room_id = current.room_id
          end
        end
      end
      unless @room_bool
        @room = Room.new
        @entry = Entry.new
      end
    end
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

  def dm
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
