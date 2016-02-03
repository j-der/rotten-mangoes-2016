class Admin::UsersController < ApplicationController

  def index
    render text: "Index for Admin"
  end

  def new
    @admin_user = User.new
  end
end
