class HomeController < ApplicationController
  def index
    @user = current_user if user_signed_in?
    @books = Book.all
  end
end
