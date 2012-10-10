class PhotosController < ApplicationController

  def new
    @photo = Photo.new
	  if params.has_key?("id")
	    @book = Book.find(params[:id])
	  end
  end

  def upload 
    "say hello"
  end 

  def add
  	@photo  = Photo.new
    uploaded_io = params[:photo][:picture]
    File.open(Rails.root.join('app','assets', 'images', uploaded_io.original_filename), 'wb+') do |file|
      file.write(uploaded_io.read)
    end

    @photo.image_path  =  uploaded_io.original_filename

    if params[:photo].has_key?("book_id")
      @book = Book.find(params[:photo][:book_id])
  	  @photo.book_id = @book.id
  	  @photo.save
  	  if @book.photo
        @book.photo = @photo
      end
  	  redirect_to("/books/#{params[:photo][:book_id]}")
  	else
  	  @photo.user_id = current_user.id
  	  @photo.save
  	  if current_user.photo
        current_user.photo = @photo
      end
      redirect_to("/users/user_page")
  	end  	  
  end

end
