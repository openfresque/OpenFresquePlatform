class TrainingSession < OpenFresk::TrainingSession
  include Decorable

  has_many :product_configuration_sessions, dependent: :destroy
  has_many :product_configurations, through: :product_configuration_sessions
end
