class Book < ActiveRecord::Base
  attr_accessible :author, :description, :price, :title, :user_id, :keyword

  has_one :photo
  belongs_to :user
end
