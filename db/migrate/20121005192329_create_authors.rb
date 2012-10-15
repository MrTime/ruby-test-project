class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.text :author
      t.integer :book_id

      t.timestamps
    end
  end
end
