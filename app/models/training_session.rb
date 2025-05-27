class TrainingSession < OpenFresk::TrainingSession
    belongs_to :language
    belongs_to :country

    string_enum category: %i[atelier formation].freeze
    string_enum format: %i[onsite online].freeze
end
