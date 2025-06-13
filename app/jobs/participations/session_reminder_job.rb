module Participations
  class SessionReminderJob < ApplicationJob
    include Rails.application.routes.url_helpers
    sidekiq_options queue: :critical

    def perform(participation_id, tenant_id)
      tenant = Tenant.find(tenant_id)
      Apartment::Tenant.switch(tenant.subdomain) do
        participation = Participation.find(participation_id)
        user = participation.user
        language = Languages::SetEmailLanguage.new(language: user.native_language).call
        subject = I18n.t(
          "participation.session_reminder.subject_#{subject_translation_key(participation)}",
          locale: language,
          organisation: organisation(participation)
        )
        ParticipationMailer.with(locale: language)
                           .session_reminder_email(subject:,
                                                   user:,
                                                   participation:,
                                                   tenant: Tenant.current)
                           .deliver_now
      end
    end

    private

    def subject_translation_key(participation)
      if participation.participant?
        "participant"
      elsif participation.training_session.qualiopi?
        participation.training_session.inter_company? ? "animator_qualiopi_inter" : "animator_qualiopi"
      else
        "animator"
      end
    end

    def organisation(participation)
      return unless participation.training_session.qualiopi?

      participation.participant? ? nil : participation.training_session.organisation
    end
  end
end
