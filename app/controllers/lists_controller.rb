class ListsController < ApplicationController

  def index
    @books = Book.all
    
    #respond_to do |format|
     # format.html # index.html.erb
      #format.json { render json: @books }
    #end
  end

  def show
    @book = Book.find(params[:id])
    @book.comments.build
    
  end
  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to :controller => 'lists', :action => 'show', notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

end
