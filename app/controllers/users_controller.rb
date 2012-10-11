class UsersController < ApplicationController

  def show
    user = User.find params[:id]
    @user = user.confirmed_at.nil? ? nil : user
   # if @user

   # if user_signed_in?
   #   @user = current_user
   # else
   #   redirect_to("/users/sign_in")
  #  end
  end

  def edit
    @user = current_user
  end

  def update
    puts "Updating!"
  end
end
