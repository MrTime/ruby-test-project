class Book < ActiveRecord::Base
  attr_accessible :author, :description, :price, :title, :comments, :comments_attributes, :created_at
  has_many :comments
  accepts_nested_attributes_for :comments
end

