class Book < ActiveRecord::Base
  attr_accessible :author, :description, :price, :title, :user_id

  has_many :line_items
  has_one :photo
  has_many :comments
  belongs_to :user
end
