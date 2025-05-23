if Rails.env.production?
  Rails.application.config.after_initialize do
    begin
      smtp_setting = SmtpSetting.first

      if smtp_setting.present?
        Rails.application.config.action_mailer.delivery_method = :smtp
        Rails.application.config.action_mailer.smtp_settings = {
                                                                 port: smtp_setting.port,
                                                                 domain: smtp_setting.domain,
                                                                 authentication: smtp_setting.authentication&.to_sym,
                                                                 user_name: smtp_setting.user_name,
                                                                 password: smtp_setting.password, # Decrypted by attr_encrypted
                                                                 enable_starttls_auto: smtp_setting.enable_starttls_auto
                                                               }.compact
      else
        Rails.logger.warn "SMTP Config Initializer: SmtpSetting not found or incomplete in database. SMTP not configured. Email delivery will likely fail."
      end
    rescue StandardError => e
      Rails.logger.error "SMTP Config Initializer: Failed to configure ActionMailer from database due to an error during initialization. SMTP not configured. Email delivery will likely fail. Error: #{e.class}: #{e.message}"
    end
  end
end