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

end
