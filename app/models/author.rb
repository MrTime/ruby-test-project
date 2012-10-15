class Author < ActiveRecord::Base
  attr_accessible :author, :book_id
  belongs_to :book
end
