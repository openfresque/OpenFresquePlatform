module Participations
  class UpdateParticipation
    include SimpleCommand

    def initialize(participant:, current_user:, training_session:)
      @participant = participant
      @current_user = current_user
      @training_session = training_session
    end

    def call
      @participation = training_session.participations.find_by(user: participant)

      @coanimator_id = training_session.participations.find_by(user_id: @current_user.id,
                                                               animator_id: @current_user.id)&.coanimator_id

      if @participation.status == Participation::Present &&
         [@current_user.id, @coanimator_id].include?(@participation.animator_id)
        animator = nil
        coanimator = nil
        status = Participation::Confirmed
        presence_recorded_at = nil
      elsif @participation.status == Participation::Confirmed
        animator = @current_user
        coanimator = @coanimator_id
        status = Participation::Present
        presence_recorded_at = Time.current
      else
        return @participation
      end

      @participation.animator = animator
      @participation.coanimator_id = coanimator
      @participation.status = status
      @participation.presence_recorded_at = presence_recorded_at
      @participation.save

      @participation
    end

    private

    attr_reader :participant, :current_user, :training_session
  end
end
