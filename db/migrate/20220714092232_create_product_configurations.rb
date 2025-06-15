class CreateProductConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :product_configurations do |t|
      t.bigint "product_id", null: false
      t.bigint "country_id", null: false
      t.integer "before_tax_price_cents"
      t.integer "tax_cents"
      t.integer "after_tax_price_cents"
      t.decimal "tax_rate", precision: 3, scale: 1
      t.string "currency"
      t.string "display_name", null: false
      t.string "description"

      t.timestamps
    end

    add_index :product_configurations, %i[product_id country_id], unique: true
  end
end
