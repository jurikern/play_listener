class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      t.string :password_salt,      :null => false, :default => ""

      t.string :name,               :null => false, :default => ""

      t.string :uid,                :null => false, :default => ""
      t.string :access_token,       :null => false, :default => ""
      t.string :refresh_token,      :null => false, :default => ""

      t.timestamps
    end

    add_index :users, :email, :unique => true
    add_index :users, :uid,   :unique => true
  end
end
