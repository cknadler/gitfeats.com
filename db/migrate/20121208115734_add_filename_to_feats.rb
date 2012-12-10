class AddFilenameToFeats < ActiveRecord::Migration
  def change
    add_column :feats, :filename, :string
  end
end
