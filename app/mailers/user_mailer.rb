class UserMailer < ApplicationMailer
  default from: 'mystorenotifications@gmail.com'

  def order_email(user)
    @user = user
    @url = 'http://intense-spire-74031.herokuapp.com/'
    mail(to: @user.email, subject: 'Thank you for your order!')
  end

end
