# Create a dummy user for testing
User.find_or_create_by!(email: 'vdaubry@gmail.com') do |user|
  user.password = 'Azerty123'
  user.firstname = 'Vincent'
  user.lastname = 'Daubry'
  user.token = SecureRandom.hex(16)
  user.refresh_token = SecureRandom.hex(16)
  user.language = 'fr'
  user.admin = true
end
puts "Created/Updated test user with email: vdaubry@gmail.com"

User.find_or_create_by!(email: 'lea.juskiewenski@fresqueduclimat.org') do |user|
  user.password = 'Azerty123'
  user.firstname = 'Lea'
  user.lastname = 'Juskiewenski'
  user.token = SecureRandom.hex(16)
  user.refresh_token = SecureRandom.hex(16)
  user.language = 'fr'
  user.admin = true
end

puts "Created/Updated test user with email: lea.juskiewenski@fresqueduclimat.org"

User.find_or_create_by!(email: 'bastien.grandjean@fresqueduclimat.org') do |user|
  user.password = 'Azerty123'
  user.firstname = 'Bastien'
  user.lastname = 'Grandjean'
  user.token = SecureRandom.hex(16)
  user.refresh_token = SecureRandom.hex(16)
  user.language = 'fr'
  user.admin = true
end

puts "Created/Updated test user with email: bastien.grandjean@fresqueduclimat.org"

# Create Languages
Language.find_or_create_by!(iso3: 'fra') do |lang|
  lang.name = 'French'
  lang.french_name = 'Français'
  lang.code = 'fr'
end
puts "Created/Updated French language"

Language.find_or_create_by!(iso3: 'eng') do |lang|
  lang.name = 'English'
  lang.french_name = 'Anglais'
  lang.code = 'en'
end
puts "Created/Updated English language"

# Create Countries
Country.find_or_create_by!(code: 'FR') do |country|
  country.name = 'France'
  country.currency_name = 'Euro'
  country.currency_code = 'EUR'
  country.tax_rate = 20
end
puts "Created/Updated France country" 