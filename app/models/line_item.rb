class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :book_id
  belongs_to :book
  belongs_to :cart

  def total_price
    self.book.price * self.quantity
  end
end
