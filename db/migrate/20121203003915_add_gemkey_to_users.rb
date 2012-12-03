class AddGemkeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gemkey, :string
  end
end
