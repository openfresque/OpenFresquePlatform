class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string "identifier", null: false
      t.string "category", null: false
      t.boolean "charged", default: false, null: false
      t.boolean "price_modifiable", default: false, null: false
      t.string "audience"

      t.timestamps
    end
  end
end
