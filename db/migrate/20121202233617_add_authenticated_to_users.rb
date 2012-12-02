class AddAuthenticatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authenticated, :boolean, :default => 0
  end
end
