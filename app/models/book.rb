class Book < ActiveRecord::Base
  attr_accessible :author, :description, :price, :title, :authors, :authors_attributes
  has_many :authors
  accepts_nested_attributes_for :authors
end
