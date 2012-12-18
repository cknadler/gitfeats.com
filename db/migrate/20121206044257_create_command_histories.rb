class CreateCommandHistories < ActiveRecord::Migration
  def change
    create_table :command_histories do |t|
      t.integer :count
      t.references :command
      t.references :user
      t.timestamps
    end

    add_index :command_histories, :command_id
    add_index :command_histories, :user_id
  end
end
