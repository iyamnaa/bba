class NewsletterMailer < ApplicationMailer
  def send_mail
    @email = params[:email]
    @campaign = params[:campaign]
    mail bcc: @email, subject: 'New Campaign on BBA'
  end
end
