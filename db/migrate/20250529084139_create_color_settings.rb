class CreateColorSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :color_settings do |t|
      t.string :primary_color, default: "#007e7c"
      t.string :secondary_color, default: "#d3d7de"

      t.timestamps
    end
  end
end
