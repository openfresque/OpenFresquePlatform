class CreatePermssionSystem < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :user_roles, :name, unique: true

    create_table :permission_actions do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :permission_actions, :name, unique: true

    create_table :rules do |t|
      t.references :permission_action, null: false, foreign_key: true
      t.string :description
      t.timestamps
    end

    # ✅ table de jointure entre rules et user_roles
    create_table :rules_user_roles, id: false do |t|
      t.references :rule, null: false, foreign_key: true
      t.references :user_role, null: false, foreign_key: true
    end

    add_index :rules_user_roles, [:rule_id, :user_role_id], unique: true
  end
end