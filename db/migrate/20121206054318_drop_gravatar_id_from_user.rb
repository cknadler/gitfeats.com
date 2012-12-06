class DropGravatarIdFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :gravatar_id
    add_column :users, :gemkey, :string
  end

  def down
  end
end
