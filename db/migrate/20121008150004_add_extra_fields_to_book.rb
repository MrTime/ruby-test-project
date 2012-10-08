class AddExtraFieldsToBook < ActiveRecord::Migration
  def change
    change_table :books do |b|
      b.integer :isbn
      b.string :genre
      b.integer :year
    end
  end
end
