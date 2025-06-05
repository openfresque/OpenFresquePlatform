class CorrectDefaultUuidForTokensInUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    change_column_default :users, :token, from: 'uuid_generate_v4()', to: -> { 'uuid_generate_v4()' }
    change_column_default :users, :refresh_token, from: 'uuid_generate_v4()', to: -> { 'uuid_generate_v4()' }
  end
end
