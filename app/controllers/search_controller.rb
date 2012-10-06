class SearchController < ApplicationController
  
   def search_books
    @book=Book.where('title LIKE ?', "%#{params[:search_title]}%").all
   end
  
  
  
end
