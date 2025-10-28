class UserRole < ApplicationRecord
  has_and_belongs_to_many :rules
  has_many :permission_actions, through: :rules

  validates :name, presence: true, uniqueness: true

  string_enum name: %i[user facilitator advanced_facilitator]
end
