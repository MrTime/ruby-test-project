class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    @user = user.confirmed_at.nil? ? nil : user
  end

  def edit
    @user = current_user
  end

  def update
  end
end
