class PermissionAction < ApplicationRecord
  has_many :rules, dependent: :destroy
  has_many :user_roles, through: :rules

  validates :name, presence: true, uniqueness: true

  string_enum name: %i[login]
end
