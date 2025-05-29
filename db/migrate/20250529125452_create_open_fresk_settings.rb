class CreateOpenFreskSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :open_fresk_settings do |t|
      t.string :NonProfitName

      t.timestamps
    end
  end
end
