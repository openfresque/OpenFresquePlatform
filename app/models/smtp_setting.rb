class SmtpSetting < ApplicationRecord
  attr_encrypted :password, key: ENV['ATTR_ENCRYPTED_KEY']
  validates :domain, :password, :user_name, presence: true
  validates :port, presence: true, numericality: { only_integer: true }
end
