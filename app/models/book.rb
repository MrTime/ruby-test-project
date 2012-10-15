class Book < ActiveRecord::Base
  attr_accessible :author, :description, :price, :title, :authors, :authors_attributes, :user_id, :isbn, :genre, :year
  has_many :authors
  accepts_nested_attributes_for :authors
  has_one :photo
  belongs_to :user
end
