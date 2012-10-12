class BooksController < ApplicationController
  # GET /books
  # GET /books.json
   before_filter :authenticate, :except => [:index, :show]

  def index
    @books = Book.all
    @kind = params[:kind]
        
    if @kind.to_i == 1
      @books = @books.sort_by!{|b| b.title}
    elsif @kind.to_i == 2
      @books = @books.sort_by!{|b| b.price}
    elsif @kind.to_i == 3
      @books = @books.sort_by!{|b| b.star}
    end
      
      
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
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
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
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

  def new_photo
   @photo = Photo.new
   @book = Book.find(params[:id])
  end

  def add_photo
    @book = Book.find(params[:photo][:book_id])
    uploaded_io = params[:photo][:picture]
      File.open(Rails.root.join('app','assets', 'images', uploaded_io.original_filename), 'wb+') do |file|
        file.write(uploaded_io.read)
      end
      @photo  = Photo.new
      @photo.book_id = @book.id
      @photo.save
      @photo.image_path  =  uploaded_io.original_filename
      @photo.save
      redirect_to("/books/#{params[:photo][:book_id]}")
  end

  private

  def authenticate
     redirect_to("/users/sign_in") unless user_signed_in?
  end

end
