class Book < ActiveRecord::Base
  attr_accessible :author, :description, :price, :title, :user_id, :isbn, :genre, :year, :rate

  has_one :photo
  belongs_to :user
end
