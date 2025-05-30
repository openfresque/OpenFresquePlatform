if Rails.env.production?
  Rails.application.config.after_initialize do
    begin
      smtp_setting = SmtpSetting.first

      if smtp_setting.present?
        settings = {
          address: smtp_setting.domain,
          port: smtp_setting.port,
          authentication: smtp_setting.authentication.to_sym,
          user_name: smtp_setting.user_name,
          password: smtp_setting.password,
          enable_starttls_auto: smtp_setting.enable_starttls_auto,
        }
        # Important : we need to set the smtp_settings and delivery_method directly on ActionMailer::Base for this to work (Rails config settings are probably applied before this initializer executes)
        ActionMailer::Base.smtp_settings = settings
        ActionMailer::Base.delivery_method = :smtp
        Rails.application.config.action_mailer.smtp_settings = settings
        Rails.application.config.action_mailer.delivery_method = :smtp
      else
        # Log a warning if settings are not found, as this is a configuration issue
        # but not necessarily a crash-worthy error during initialization.
        Rails.logger.warn "SMTP Config Initializer: SmtpSetting not found in database. SMTP not configured. Email delivery will likely fail."
      end
    rescue StandardError => e
      # Log a comprehensive error message if any part of the SMTP setup fails.
      Rails.logger.error "SMTP Config Initializer: Failed to configure ActionMailer from database. SMTP not configured. Email delivery will likely fail. Error: #{e.class}: #{e.message}, Backtrace: #{e.backtrace.first(5).join("
")}"
    end
  end
end