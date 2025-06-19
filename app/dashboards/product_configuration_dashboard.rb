require "administrate/base_dashboard"

class ProductConfigurationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    product: Field::BelongsTo.with_options(class_name: "Product"),
    country: Field::BelongsTo.with_options(class_name: "Country"),
    id: Field::Number,
    before_tax_price_cents: Field::Number,
    tax_cents: Field::Number,
    after_tax_price_cents: Field::Number,
    tax_rate: Field::Number,
    display_name: Field::String,
    currency: Field::String,
    description: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    product
    country
    before_tax_price_cents
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    product
    country
    before_tax_price_cents
    tax_cents
    after_tax_price_cents
    tax_rate
    display_name
    currency
    description
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    product
    country
    before_tax_price_cents
    tax_cents
    after_tax_price_cents
    tax_rate
    display_name
    currency
    description
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how product configurations are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(product_configuration)
    # "ProductConfiguration ##{product_configuration.id}"
    "##{product_configuration.id} - #{product_configuration.product&.identifier} - #{product_configuration.country&.name}"
  end
end
