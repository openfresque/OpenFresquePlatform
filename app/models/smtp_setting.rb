class SmtpSetting < ApplicationRecord
  ENCRYPTION_KEY_HEX = ENV['ATTR_ENCRYPTED_KEY']

  if ENCRYPTION_KEY_HEX.nil? || ENCRYPTION_KEY_HEX.length != 64
    raise "ATTR_ENCRYPTED_KEY environment variable not set or not a 64-character hex string."
  end

  # Decode the hex key into raw bytes for attr_encrypted
  DECODED_KEY = [ENCRYPTION_KEY_HEX].pack('H*').freeze

  attr_encrypted :password, key: DECODED_KEY
  validates :domain, :password, :user_name, presence: true
  validates :port, presence: true, numericality: { only_integer: true }
end
