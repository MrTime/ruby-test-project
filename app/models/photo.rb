class Photo < ActiveRecord::Base
  attr_accessible :image_path, :user_id, :book_id

  belongs_to :user
  belongs_to :book
end
