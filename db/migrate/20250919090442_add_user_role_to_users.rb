class AddUserRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_role, :string, null: true, default: 'user'
  end
end
