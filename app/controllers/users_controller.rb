class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]
  before_action :configure_sign_up_params, only: [:create]

  def index
    @user_all = User.all
    @book = Book.new
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @user_book = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def following
     @user = User.find(params[:id])
     @users = @user.following.all
  end
    
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
  end
  
  def zipedit
  params.require(:user).permit(:postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
  protected
 
  def configure_sign_up_params
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
end
