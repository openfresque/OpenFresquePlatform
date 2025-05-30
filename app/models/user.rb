class User < OpenFresk::User
  has_secure_password

  def country
    Country.find_by(name: 'France')
  end
end
  