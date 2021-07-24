class UsersController < ApplicationController
  layout 'no_sidebar', :only => [:new]
  
  before_action :setuser, only: [:show, :photos, :contests, :likes]
  
  def show
  end

  def photos
    @pagy, @photos = pagy(@user.photos.order(id: :desc), items: 20)
  end

  def contests
    @pagy, @contests = pagy(@user.contests.order(id: :desc), items: 20)
  end

  def likes
    @pagy, @photos = pagy(@user.liked_photos.order("user_photo_likes.id DESC"), items: 20)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:main] = 'ユーザー登録が完了しました。'
      session[:user_id] = @user.id
      
      redirect_to @user
    else
      flash.now[:accent] = 'ユーザーの登録に失敗しました。'
      render :new, layout: "no_sidebar"
    end
  end

  def new
    @user = User.new
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def setuser
    @user = User.find(params[:id])
  end
end
