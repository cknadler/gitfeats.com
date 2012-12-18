class AddApikeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :apikey, :string
  end
end
