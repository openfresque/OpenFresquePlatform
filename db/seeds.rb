
# Create a dummy user for testing
user = User.create!(
  email: 'vdaubry@gmail.com',
  password: 'Azerty123',
  firstname: 'Vincent',
  lastname: 'Daubry',
  token: SecureRandom.hex(16),
  refresh_token: SecureRandom.hex(16),
  language: 'fr',
  admin: true
)
puts "Created test user with email: #{user.email}" 

user = User.create!(
  email: 'lea.juskiewenski@fresqueduclimat.org',
  password: 'Azerty123',
  firstname: 'Lea',
  lastname: 'Juskiewenski',
  token: SecureRandom.hex(16),
  refresh_token: SecureRandom.hex(16),
  language: 'fr',
  admin: true
)

puts "Created test user with email: #{user.email}" 

user = User.create!(
  email: 'bastien.grandjean@fresqueduclimat.org',
  password: 'Azerty123',
  firstname: 'Bastien',
  lastname: 'Grandjean',
  token: SecureRandom.hex(16),
  refresh_token: SecureRandom.hex(16),
  language: 'fr',
  admin: true
)

puts "Created test user with email: #{user.email}" 