require "administrate/base_dashboard"

class TransactionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    participation: Field::BelongsTo,
    product_configuration: Field::BelongsTo,
    coupon: Field::BelongsTo,
    id: Field::Number,
    stripe_response: Field::Text,
    status: Field::String,
    before_tax_price_cents: Field::Number,
    tax_cents: Field::Number,
    after_tax_price_cents: Field::Number,
    currency: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    payment_intent_id: Field::String,
    billing_info: Field::HasOne
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    payment_intent_id
    participation
    product_configuration
    status
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    participation
    product_configuration
    coupon
    id
    stripe_response
    status
    before_tax_price_cents
    tax_cents
    after_tax_price_cents
    currency
    created_at
    updated_at
    payment_intent_id
    billing_info
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    participation
    product_configuration
    coupon
    stripe_response
    status
    before_tax_price_cents
    tax_cents
    after_tax_price_cents
    currency
    payment_intent_id
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

  # Overwrite this method to customize how transactions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(transaction)
  #   "Transaction ##{transaction.id}"
  # end
end
