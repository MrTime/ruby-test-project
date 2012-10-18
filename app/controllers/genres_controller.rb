class GenresController < ApplicationController

  def genre
    @sbooks = Book.all
    @books = []
    @books.push(@sbooks[0])
    @sbooks.each do |b|
      if @books.last.genre != b.genre 
        @books.push(b)
      end  
    end
    if params[:id] != nil
      @book = Book.find(params[:id])
      @genre = @book.genre
    @sbooks = Book.find(:all, :conditions => {:genre => @genre})
    end
    respond_to do |format|
      format.html 
      format.json { render json: @books }
    end
  end
  
  
end