class TrainingSession < OpenFresk::TrainingSession
    include TrainingSessions::Timings
    include TrainingSessions::Staffing
    
    belongs_to :language
    belongs_to :country

    string_enum category: %i[atelier formation].freeze
    string_enum format: %i[onsite online].freeze

    #TODO: remove me when timezones are implemented
    def local_start_time
        start_time
    end

    #TODO: remove me when timezones are implemented
    def local_end_time
        end_time
    end

    #TODO: remove me when seats are implemented
    def confirmed_present_count
        1
    end

    #TODO: remove me when seats are implemented
    def animator_count
        1
    end
end
