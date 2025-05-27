json.extract! country, :id, :name, :code, :currency_name, :currency_code, :external_id, :tax_rate, :created_at, :updated_at
json.url country_url(country, format: :json)
