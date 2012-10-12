class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
    else
      redirect_to("/users/sign_in")
    end
    @books = Book.all
  end
end
