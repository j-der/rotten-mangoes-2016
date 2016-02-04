class Admin::UsersController < ApplicationController

  layout 'admin'
  # def index

  # end

  def new
    @admin_user = User.new
  end

  def create
    @admin_user = User.new(admin_user_params)
    @admin_user.admin = true

    if @admin_user.save
      redirect_to movies_path, notice: "You are now an admin!"
    else
      render :new
    end
  end

  protected

  def admin_user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end
end
