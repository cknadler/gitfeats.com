class CreateCompletedFeats < ActiveRecord::Migration
  def change
    create_table :completed_feats do |t|
      t.references :user
      t.references :feat

      t.timestamps
    end
    add_index :completed_feats, :user_id
    add_index :completed_feats, :feat_id
  end
end
