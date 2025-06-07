class ApplicationMailer < ActionMailer::Base
  default from: -> { SmtpSetting.first!.from_address }
  layout "mailer"
end
