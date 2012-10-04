class AddUserIdColumnToBook < ActiveRecord::Migration
  def change
    change_table :books do |b|
      b.integer :user_id
    end
  end
end
