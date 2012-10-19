class BooksController < ApplicationController
  # GET /books
  # GET /books.json

   before_filter :authenticate, :except => [:index, :show]

  def index

    @books_partial = Book.paginate(:page => params[:page], :per_page => 5)

    @books = Book.all
    @search = params[:search]
    
    @books.each do |b|
      if b.isbn == @search.to_i && @search !="" && @search !=nil
        @books = Book.find(:all, :conditions => {:isbn => @search})
      end
    end

    if params[:part]
      render :partial => @books_partial, :layout => false
    else
      respond_to do |format|
        format.html # index.html.erb                                                                                         ф
        format.json { render json: @books }
      end
    end
  end

  # GET /books/1
  # GET /books/1.json
#  private

  def show
    @book = Book.find(params[:id])
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    #For uploading images
    @photo = Photo.new
    @book = Book.new
    @book.authors.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    #For uploading images
    @photo = Photo.new
    @book = Book.find(params[:id])
    @book.authors.build
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])
    @book.user_id = current_user.id
    @book.owner_login = current_user.email

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private

  def authenticate
     redirect_to("/users/sign_in") unless user_signed_in?
  end

end
