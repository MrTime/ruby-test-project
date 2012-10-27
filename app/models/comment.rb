class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :book_id
  belongs_to :book
  belongs_to :user

  validates_presence_of :content

  scope :desc, order("created_at DESC")
end
