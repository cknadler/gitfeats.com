class CreateFeats < ActiveRecord::Migration
  def change
    create_table :feats do |t|
      t.string :name
      t.string :description
      t.integer :completed_count

      t.timestamps
    end
  end
end
