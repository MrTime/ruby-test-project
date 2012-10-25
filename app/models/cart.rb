class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :user
  has_many :line_items

  def add_book(article_id)
    current_item = line_items.find_by_book_id(article_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(book_id: article_id)
    end
    current_item
  end

  def subtotal
    self.line_items.to_a.sum { |item| item.total_price }
  end

  def shiping
  end

  def empty?
    self.line_items.count == 0
  end
end

# == Schema Information
#
# Table name: carts
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer(4)
