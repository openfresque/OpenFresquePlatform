namespace :users do
  desc "Updates token and refresh_token for all users with new UUIDs"
  task fix_uuid_tokens: :environment do
    User.find_each do |user|
      new_token = SecureRandom.uuid
      new_refresh_token = SecureRandom.uuid
      user.update_columns(token: new_token, refresh_token: new_refresh_token)
    end
  end
end 