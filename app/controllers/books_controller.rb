class BooksController < ApplicationController
  # GET /books
  # GET /books.json
   before_filter :authenticate, :except => [:index, :show]

  def index
    @books = Book.all
    @search = params[:search]
    
    @books.each do |b|
      if b.isbn == @search.to_i && @search !="" && @search !=nil
        @books = Book.find(:all, :conditions => {:isbn => @search})
      end
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
    if current_user != nil
      @rate = false
      rating = Rate.where("user_id = ? AND book_id = ?", current_user.id, params[:id])

      if !rating.empty? 
        @rate = true
      end  
    end  
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

  def rate
    user_id = current_user.id
    book_id = params[:book_id]
    rating = Rate.where("user_id = ? AND book_id = ?", user_id, book_id)

    if rating.empty?
      rate = Rate.new
      rate.rate = params[:id]
      rate.book_id = book_id
      rate.user_id = user_id
      rate.save

      #Calculates the average assessment
      middle = middle_mark book_id
      
      book = Book.find(book_id)
      book.middle_rate = middle
      book.save

      response =  middle
    else
      book = Book.find(book_id)
      
      response = book.middle_rate #'You have already rate this book'
    end

    render :json => response
      
  end

  private

  def authenticate
     redirect_to("/users/sign_in") unless user_signed_in?
  end

  #Calculates the average assessment
  def middle_mark book_id
    ratings = Rate.where("book_id = ?", book_id)

    if !ratings.empty?
      sum = 0

      ratings.each do |rate|
        sum += rate.rate.to_i
      end  

      return sum/ratings.size  
    end  
  end 
end
