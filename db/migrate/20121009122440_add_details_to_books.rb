class AddDetailsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :isbn, :integer
    add_column :books, :genre, :string
    add_column :books, :year, :integer
  end
end
