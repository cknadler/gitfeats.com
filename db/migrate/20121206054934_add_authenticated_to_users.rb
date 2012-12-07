class AddAuthenticatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authenticated, :boolean, :default => FALSE
  end
end
