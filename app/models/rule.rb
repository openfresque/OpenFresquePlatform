class Rule < ApplicationRecord
  has_and_belongs_to_many :user_roles
  belongs_to :permission_action

  validates :description, presence: true
end
