class User < OpenFresk::User
  has_secure_password
  has_many :participations, dependent: :destroy

  def country
    Country.find_by(name: 'France')
  end
end
  