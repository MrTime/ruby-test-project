class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :user_id
      t.timestamps
    end
  end
end
