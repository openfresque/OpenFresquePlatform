class ProductConfiguration < OpenFresk::ProductConfiguration
    validates_uniqueness_of :country_id, scope: :product_id
end
