class CreateProductConfigurationSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :product_configuration_sessions do |t|
      t.references :product_configuration, null: false, foreign_key: true, index: { name: 'index_prod_config_sess_on_prod_config_id' }
      t.references :training_session, null: false, foreign_key: true, index: { name: 'index_prod_config_sess_on_train_sess_id' }

      t.timestamps
    end
  end
end
