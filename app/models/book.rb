class Book < ActiveRecord::Base
  attr_accessible :author, :description, :price, :title, :user_id

  has_one :photo
  belongs_to :user
  has_one :rate
end
