class TrainingSessionsController < ::OpenFresk::TrainingSessionsController
    def new
        @training_session = TrainingSession.new
    end

    def create
        command = ::TrainingSessions::CreateTrainingSession.new(
          training_session_params:,
          current_user:,
          contact: params.dig(:contact),
          past: params.dig(:past),
          context: params.dig(:context)
        )
        @training_session = command.call
    
        if @training_session.errors.blank?
          redirect_to training_sessions_path,
                      notice: t("training_sessions.created")
        else
          render :new
        end
    end

    private
    def training_session_params
        params
          .require(:training_session)
          .permit(
            :description,
            :language_id,
            :country_id,
            :date,
            :start_hour,
            :end_hour,
            :category,
            :format,
            :connexion_url,
            :room,
            :street,
            :city,
            :zip,
            :country,
            :capacity,
            :public,
            :session_info,
            :latitude, 
            :longitude
          )
      end
      
end
