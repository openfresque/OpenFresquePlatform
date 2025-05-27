class CreateLanguages < ActiveRecord::Migration[7.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :iso3
      t.string :french_name
      t.string :code

      t.timestamps
    end
  end
end
