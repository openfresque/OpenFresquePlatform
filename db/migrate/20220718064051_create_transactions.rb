class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :participation, foreign_key: true
      t.references :product_configuration, foreign_key: true
      t.text :stripe_response
      t.string :status
      t.integer :before_tax_price_cents
      t.integer :tax_cents
      t.integer :after_tax_price_cents
      t.string :currency
      t.string :payment_intent_id

      t.timestamps
    end
  end
end
