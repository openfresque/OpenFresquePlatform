class TrainingSessionDecorator < ApplicationDecorator
  def remuneration_processing_deadline
    participations.maximum(:remuneration_payed_at)&.+ 7.days
  end

  def formatted_date
    I18n.l(date, format: :long)
  end

  def formatted_start_time
    local_start_time.strftime("%H:%M")
  end

  def formatted_end_time
    local_end_time.strftime("%H:%M")
  end

  def formatted_time_zone
    I18n.t("time_of", time_zone:)
  end

  def formatted_full_date
    I18n.t("emails.session_date", date: formatted_date, start_time: formatted_start_time, end_time: formatted_end_time, timezone: formatted_time_zone)
  end

  def formatted_location
    if onsite?
      I18n.t("emails.session_address", address: formatted_onsite_location)
    else
      I18n.t("emails.visio_url", url: connexion_url)
    end
  end

  def formatted_onsite_location
    [
      room,
      street,
      zip
    ].compact_blank.join(", ")
  end

  def formatted_visio_url
    I18n.t("emails.visio_url", visio_url: connexion_url)
  end
end
