if Rails.env.production?
  Rails.application.config.after_initialize do
    Rails.logger.info "SMTP_CONFIG_DEBUG: Initializer running in #{Process.pid}"
    key_value = ENV['ATTR_ENCRYPTED_KEY']
    if key_value.blank?
      Rails.logger.warn "SMTP_CONFIG_DEBUG: ATTR_ENCRYPTED_KEY is BLANK or NIL."
    elsif key_value.length.odd?
      Rails.logger.warn "SMTP_CONFIG_DEBUG: ATTR_ENCRYPTED_KEY has ODD length: #{key_value.length}, value (first 5 chars): #{key_value.first(5)}"
    else
      Rails.logger.info "SMTP_CONFIG_DEBUG: ATTR_ENCRYPTED_KEY seems present and even length: #{key_value.length}, value (first 5 chars): #{key_value.first(5)}"
    end

    begin
      db_active = ActiveRecord::Base.connection.active?
      Rails.logger.info "SMTP_CONFIG_DEBUG: ActiveRecord connection active? #{db_active}"
    rescue StandardError => db_err
      Rails.logger.error "SMTP_CONFIG_DEBUG: Error checking ActiveRecord connection: #{db_err.message}"
    end

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