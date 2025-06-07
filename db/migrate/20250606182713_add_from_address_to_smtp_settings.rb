class AddFromAddressToSmtpSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :smtp_settings, :from_address, :string
  end
end
