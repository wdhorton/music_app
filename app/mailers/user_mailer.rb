class UserMailer < ApplicationMailer
  default from: 'no-reply@musicapp.com'

  def activation_email(user, url)
    @user = user
    @url = url
    mail(to: user.email, subject: 'Activate your MusicApp account')
  end
end
