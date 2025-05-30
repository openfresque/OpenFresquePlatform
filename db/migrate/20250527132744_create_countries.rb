class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code
      t.string :currency_name
      t.string :currency_code
      t.string :external_id
      t.integer :tax_rate, default: 0, null: false

      t.timestamps
    end
  end
end
