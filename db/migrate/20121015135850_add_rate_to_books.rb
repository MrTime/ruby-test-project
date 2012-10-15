class AddRateToBooks < ActiveRecord::Migration
  def change
    add_column :books, :rate, :integer
  end
end
