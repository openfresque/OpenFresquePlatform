require "administrate/base_dashboard"

class RuleDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    user_roles: Field::HasMany,
    permission_action: Field::BelongsTo,
    description: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    user_roles
    permission_action
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    user_roles
    permission_action
    description
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    user_roles
    permission_action
    description
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(rule)
    "#{rule.user_roles.map(&:name).join(', ')} → #{rule.permission_action&.name}"
  end
end
