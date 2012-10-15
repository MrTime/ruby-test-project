class Book < ActiveRecord::Base
  attr_accessible :author, :description, :price, :title, :authors, :authors_attributes, :user_id, :isbn, :genre, :year, :rate
  has_many :authors
  accepts_nested_attributes_for :authors
  has_one :photo
  has_many :comments
  belongs_to :user
end
