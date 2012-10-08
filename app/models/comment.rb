class Comment < ActiveRecord::Base
  belongs_to :book
  attr_accessible :book_id, :name, :textt

end
