class UserMailer < ApplicationMailer
  default from: 'mystorenotifications@gmail.com'

  def order_email(user)
    @user = user
    @items = @user.get_cart_items
    @url = 'http://localhost.com/login'
    mail(to: @user.email, subject: 'Thank you for your order!')
  end

end
