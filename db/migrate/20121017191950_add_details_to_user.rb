class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :fullname, :string
    add_column :users, :shortbio, :string
    add_column :users, :weburl, :string
  end
end
