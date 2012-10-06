class Book < ActiveRecord::Base
  attr_accessible :author, :description, :genre, :isbn, :price, :title, :year
end
