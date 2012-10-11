class RegistrationsController < Devise::RegistrationsController

  def after_inactive_sign_up_path_for(resource)
    "/"
  end
  def edit
    @photo = Photo.new
  end
end
