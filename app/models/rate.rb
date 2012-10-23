class Rate < ActiveRecord::Base
  attr_accessible :book_id, :rate, :user_id

  belongs_to :user
  belongs_to :book
end
