class UsersController < ApplicationController
  before_action :require_current_user, only: [:show]
	before_action :deny_admin, only: [:show]

  def index
    @users = User.all
  end

  # ADD IF STATEMENT SO YOU KNOW WHICH ONE OF THESE TO USE
  def show
    @user = current_user
    # @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path(@user)
      flash[:success] = "You have been registered and logged in!"
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:success] = "Your profile has been updated!"
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_name, :password, :password_confirmation, :address, :zip, :city, :state)
  end
end
