class Country < ApplicationRecord
  has_many :product_configurations, dependent: :destroy
  has_many :products, through: :product_configurations
end
