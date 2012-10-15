class ChangeStringToInteger < ActiveRecord::Migration
  change_table :comments do |t|
    t.change :user_id, :integer
    t.change :book_id, :integer
  end
end
