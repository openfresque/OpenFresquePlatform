class SmtpSetting < ApplicationRecord
  attr_encrypted :password, key: [ENV['ATTR_ENCRYPTED_KEY']].pack('H*')
  validates :domain, :password, :user_name, presence: true
  validates :port, presence: true, numericality: { only_integer: true }
end
