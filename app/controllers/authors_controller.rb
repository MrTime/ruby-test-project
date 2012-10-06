class AuthorsController < ApplicationController
  # List unique authors /authors/list_authors
  def list_authors
    @books = Book.select(:author).uniq

    respond_to do |format|
      format.html # list_authors.html.erb
      format.json { render json: @books }
    end
  end

  # List of books by author /authors/books_author/:author
  def books_author
  	@books = Book.where("author = '#{params[:author]}'")

  	respond_to do |format|
      format.html # list_authors.html.erb
      format.json { render json: @books }
    end
  end	

end
