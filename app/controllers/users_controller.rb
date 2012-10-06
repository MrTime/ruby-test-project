class UsersController < ApplicationController

  def user_page
		if user_signed_in?
			@user = current_user
		else
			redirect_to("/users/sign_in")
		end
	end

   def successful_registration
   end

	def new_photo
		@photo = Photo.new
	end	

	def add_photo
		uploaded_io = params[:photo][:picture]
       	File.open(Rails.root.join('app','assets', 'images', uploaded_io.original_filename), 'wb+') do |file|
       	  file.write(uploaded_io.read) 
        end
     	@photo  = Photo.new
     	@photo.user_id = current_user.id
     	@photo.save
     	@photo.image_path  =  uploaded_io.original_filename
     	@photo.save 
      if current_user.photo
        current_user.photo = @photo
      end   
     	redirect_to("/users/user_page")
	end	
end
