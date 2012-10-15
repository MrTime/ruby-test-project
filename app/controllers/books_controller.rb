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

    @sbooks = Book.all
    @kind = params[:kind]
#    @rates = Rate.all
    if @kind.to_i == 1
      @books = @books.sort_by!{|b| b.title}
    elsif @kind.to_i == 2
      @books = @books.sort_by!{|b| b.price}
    elsif @kind.to_i == 3
      @books = []
      @rates = @rates.sort_by!{|r| r.rate}.reverse
      @rates.each do |r|
        @sbooks.each do |b|
          if r.book_id == b.id 
            @books.push(b)
          end  
        end 
      end
    elsif @kind.to_i == 4
      @books = @books.sort_by!{|b| b.comments.size}.reverse
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
