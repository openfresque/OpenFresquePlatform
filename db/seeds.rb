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

Country.find_or_create_by!(code: 'BE') do |country|
  country.name = 'Belgium'
  country.currency_name = 'Euro'
  country.currency_code = 'EUR'
  country.tax_rate = 21
end
puts "Created/Updated Belgium country"

# Create Products
product1 = Product.find_or_create_by!(identifier: 'ATELIER_FRESQUE_DU_NUMERIQUE_ADULTES') do |product|
  product.category = 'ATELIER'
  product.audience = 'GENERAL_PUBLIC'
  product.charged = true
  product.price_modifiable = true
end
puts "Created/Updated product: ATELIER_FRESQUE_DU_NUMERIQUE_ADULTES"

product2 = Product.find_or_create_by!(identifier: 'FORMATION_ANIMATION_FRESQUE_DU_NUMERIQUE') do |product|
  product.category = 'FORMATION'
  product.audience = 'GENERAL_PUBLIC'
  product.charged = true
  product.price_modifiable = false
end
puts "Created/Updated product: FORMATION_ANIMATION_FRESQUE_DU_NUMERIQUE"

# Create ProductConfigurations
france = Country.find_by(code: 'FR')
belgium = Country.find_by(code: 'BE')

ProductConfiguration.find_or_create_by!(product: product1, country: france) do |pc|
  pc.before_tax_price_cents = 1000
  pc.tax_rate = france.tax_rate
  pc.tax_cents = pc.before_tax_price_cents * (pc.tax_rate / 100)
  pc.after_tax_price_cents = pc.before_tax_price_cents + pc.tax_cents
  pc.display_name = "Fresque du Numérique - Adultes (France)"
  pc.currency = france.currency_code
  pc.description = "Animation de l'atelier Fresque du Numérique pour adultes en France."
end
puts "Created/Updated product configuration for product1 in France"

ProductConfiguration.find_or_create_by!(product: product1, country: belgium) do |pc|
  pc.before_tax_price_cents = 1200
  pc.tax_rate = belgium.tax_rate
  pc.tax_cents = pc.before_tax_price_cents * (pc.tax_rate / 100)
  pc.after_tax_price_cents = pc.before_tax_price_cents + pc.tax_cents
  pc.display_name = "Fresque du Numérique - Adultes (Belgique)"
  pc.currency = belgium.currency_code
  pc.description = "Animation de l'atelier Fresque du Numérique pour adultes en Belgique."
end
puts "Created/Updated product configuration for product1 in Belgium"

ProductConfiguration.find_or_create_by!(product: product2, country: france) do |pc|
  pc.before_tax_price_cents = 25000
  pc.tax_rate = france.tax_rate
  pc.tax_cents = pc.before_tax_price_cents * (pc.tax_rate / 100)
  pc.after_tax_price_cents = pc.before_tax_price_cents + pc.tax_cents
  pc.display_name = "Formation à l'animation - Fresque du Numérique (France)"
  pc.currency = france.currency_code
  pc.description = "Formation à l'animation de la Fresque du Numérique en France."
end
puts "Created/Updated product configuration for product2 in France"

ProductConfiguration.find_or_create_by!(product: product2, country: belgium) do |pc|
  pc.before_tax_price_cents = 26000
  pc.tax_rate = belgium.tax_rate
  pc.tax_cents = pc.before_tax_price_cents * (pc.tax_rate / 100)
  pc.after_tax_price_cents = pc.before_tax_price_cents + pc.tax_cents
  pc.display_name = "Formation à l'animation - Fresque du Numérique (Belgique)"
  pc.currency = belgium.currency_code
  pc.description = "Formation à l'animation de la Fresque du Numérique en Belgique."
end
puts "Created/Updated product configuration for product2 in Belgium" 