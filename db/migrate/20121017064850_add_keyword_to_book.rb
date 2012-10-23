class AddKeywordToBook < ActiveRecord::Migration
  def change
    add_column :books, :keyword, :string
  end
end
