class CreateApiTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :api_tokens do |t|
      t.string :token
      t.string :label
      t.timestamps
    end
    add_index :api_tokens, :token
  end
end
