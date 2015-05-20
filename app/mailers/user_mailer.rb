class UserMailer < ApplicationMailer
  default from: "notifications@example.com"

  def notice_exam user
    mail to: user.email, subject: t("mailer.email_notice")
  end
end
