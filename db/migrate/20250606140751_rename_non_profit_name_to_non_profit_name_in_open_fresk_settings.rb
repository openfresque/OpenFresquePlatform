class RenameNonProfitNameToNonProfitNameInOpenFreskSettings < ActiveRecord::Migration[7.0]
  def change
    rename_column :open_fresk_settings, :NonProfitName, :non_profit_name
  end
end
