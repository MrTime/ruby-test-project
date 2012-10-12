class AddOwnerLoginFieldToBook < ActiveRecord::Migration
  def change
    change_table :books do |b|
      b.string :owner_login
    end
  end
end
