class CreateSmtpSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :smtp_settings do |t|
      t.integer :port, null: false
      t.string :domain, null: false
      t.string :authentication, null: false, default: "plain"
      t.string :user_name, null: false
      t.string :encrypted_password, null: false
      t.string :encrypted_password_iv, null: false
      t.boolean :enable_starttls_auto, null: false, default: true

      t.timestamps
    end
  end
end
