class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid
      t.string  :provider
      t.string  :nickname
      t.string  :email
      t.string  :token
      t.timestamps
    end
  end
end
