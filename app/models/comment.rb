class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :book_id
  belongs_to :book
  belongs_to :user
end
