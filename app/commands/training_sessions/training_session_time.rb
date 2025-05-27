module TrainingSessions
  module TrainingSessionTime
    def set_training_time(training_session:, params:, past:)
      date = Date.parse(params.delete(:date))
      training_session.date = date
      if ["true", true].include?(past)
        training_session.start_time = Time.find_zone(params[:time_zone]).parse("00:00", date).utc
        training_session.end_time = Time.find_zone(params[:time_zone]).parse("00:00", date).utc
        params.delete(:start_hour)
        params.delete(:end_hour)
      else
        training_session.start_time = Time.find_zone(params[:time_zone]).parse(params.delete(:start_hour), date).utc
        training_session.end_time = Time.find_zone(params[:time_zone]).parse(params.delete(:end_hour), date).utc
      end
    end
  end
end
