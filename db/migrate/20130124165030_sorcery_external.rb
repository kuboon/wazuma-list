class SorceryExternal < ActiveRecord::Migration
  def self.up
    create_table :authentications do |t|
      t.integer :user_id, :null => false
      t.string :provider, :uid, :null => false
      t.text :access_token_hash
      t.text :user_info_hash

      t.timestamps
    end
    add_index :authentications, [:user_id, :provider], unique: true
  end

  def self.down
    drop_table :authentications
  end
end
