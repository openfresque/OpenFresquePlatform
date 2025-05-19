class SmtpSetting < ApplicationRecord
  attr_encrypted :password, key: :encryption_key
  validates :domain, :password, :user_name, presence: true
  validates :port, presence: true, numericality: { only_integer: true }

  private

  def encryption_key
    # Convert the 64-character hex string to a 32-byte binary key required by the AES256 encryption algorithm
    [ENV['ATTR_ENCRYPTED_KEY']].pack('H*') 
  end
end
