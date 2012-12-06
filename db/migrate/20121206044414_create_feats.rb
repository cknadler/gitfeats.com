class CreateFeats < ActiveRecord::Migration
  def change
    create_table :feats do |t|
      t.string :name
      t.text :description
      t.references :command
      t.integer :threshold

      t.timestamps
    end
    add_index :feats, :command_id
  end
end
