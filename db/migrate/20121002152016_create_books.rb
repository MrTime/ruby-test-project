class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.timestamps
    end
  end
end
