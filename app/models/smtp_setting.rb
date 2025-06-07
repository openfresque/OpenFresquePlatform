class SmtpSetting < ApplicationRecord
  attr_encrypted :password, key: :encryption_key
  validates :domain, :user_name, :from_address, presence: true
  validates :password, presence: true, on: :create
  validates :port, presence: true, numericality: { only_integer: true }

  private

  def encryption_key
    key = ENV['ATTR_ENCRYPTED_KEY']
    unless key.present? && key.match?(/\A[0-9a-fA-F]{64}\z/)
      raise "ATTR_ENCRYPTED_KEY must be set as an environment variable and be a 64-character hex string."
    end
    # Convert the 64-character hex string to a 32-byte binary key required by the AES256 encryption algorithm
    [key].pack('H*')
  end
end
