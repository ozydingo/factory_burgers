class MakeUsersLoginAndEmailUnique < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :login, {unique: true}
    add_index :users, :email, {unique: true}
  end
end
