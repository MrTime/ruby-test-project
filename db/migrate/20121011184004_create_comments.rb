class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.string :book_id
      t.string :user_id

      t.timestamps
    end
  end
end
