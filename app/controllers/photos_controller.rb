class PhotosController < ApplicationController

  def new
    @photo = Photo.new
	  if params.has_key?("id")
	    @book = Book.find(params[:id])
	  end
  end

  def create
    #puts params.inspect

  	@photo  = Photo.new
    uploaded_io = params[:photo][:picture]
    File.open(Rails.root.join('app','assets', 'images', uploaded_io.original_filename), 'wb+') do |file|
      file.write(uploaded_io.read)
    end

    @photo.image_path  =  uploaded_io.original_filename

    if params.has_key?("book_id")
      @book = Book.find(params[:book_id])
  	  @photo.book_id = @book.id
  	  @photo.save
  	  if @book.photo
        @book.photo = @photo
      end
  	  redirect_to("/books/#{params[:book_id]}")
    elsif params.has_key?("user_id")
  	  @photo.user_id = current_user.id
  	  @photo.save
  	  if current_user.photo
        current_user.photo = @photo
      end
      redirect_to("/users/#{params[:user_id]}")
  	end
  end

end
