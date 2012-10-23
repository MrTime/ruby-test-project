class AddMiddleRateToBooks < ActiveRecord::Migration
  def change
    add_column :books, :middle_rate, :integer
  end
end
