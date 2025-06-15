class CreateBillingInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :billing_infos do |t|
      t.references :user, foreign_key: true
      t.references :contact, foreign_key: {to_table: :users}
      t.references :transaction, foreign_key: true

      t.timestamps
    end
  end
end
