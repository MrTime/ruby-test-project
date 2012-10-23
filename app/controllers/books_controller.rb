class BooksController < ApplicationController
  # GET /books
  # GET /books.json

   before_filter :authenticate, :except => [:index, :show]

  def index
    @user = current_user
    @books_partial = Book.paginate(:page => params[:page], :per_page => 5)
    @books = Book.all
    @search = params[:search]

    @books.each do |b|
      if b.isbn == @search.to_i && @search !="" && @search !=nil
        @books = Book.find(:all, :conditions => {:isbn => @search})
      end
    end

    @sbooks = Book.all
    @kind = params[:kind]
#    @rates = Rate.all
    if @kind.to_i == 1
      @books = @books.sort_by!{|b| b.title}
    elsif @kind.to_i == 2
      @books = @books.sort_by!{|b| b.price}
    elsif @kind.to_i == 3
      @books = @books.sort_by!{|b| b.middle_rate}.reverse
    elsif @kind.to_i == 4
      @books = @books.sort_by!{|b| b.comments.size}.reverse
    end

    if params[:part]
      render :partial => @books_partial, :layout => false
    else
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @books }
      end
    end
  end

  # GET /books/1
  # GET /books/1.json
#  private

  def show
    @book = Book.find(params[:id])
    @current_id = params[:id]
    @sbooks = Book.all
    @keys = []
    h = Hash.new
    @boo = []
    @final_keys = []
    @books = []
    if @book.keyword != nil
      @show_book_keys = @book.keyword.split(" ")

# Search for similar books
    @sbooks.each do |b|
      if b.keyword != nil
        @keys = b.keyword.split(" ")
      @same_key = @keys&@show_book_keys
      if @same_key[0] != nil
        @boo.push(b.keyword)
        h[b.keyword] = @same_key.size
      end
      end
    end

# Sorting similar books by amount of key words
    h.sort{|k, v| v[1]<=>k[1]}.each{|e| @final_keys<<e[0]}

# Writing books into array
    @final_keys.each do |f|
      @books += Book.find(:all, :conditions => {:keyword => f})
    end
    else
      @books = Book.all
    end
# Deleting book owner of show_page
    @books.delete_if {|b| b.id.to_i == @current_id.to_i}

    @rate = false
    rating = Rate.where("user_id = ? AND book_id = ?", current_user.id, params[:id])

    if !rating.empty?
      @rate = true
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
