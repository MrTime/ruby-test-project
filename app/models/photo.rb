class Photo < ActiveRecord::Base
  attr_accessible :image_path, :user_id

  belongs_to :user
end
