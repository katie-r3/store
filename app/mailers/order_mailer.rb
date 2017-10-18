class OrderMailer < ApplicationMailer
  default from: 'thestore909090@gmail.com'

  def order_status(user, purchase)
    @user = user
    @purchase = purchase
    @url = 'http://intense-spire-74031.herokuapp.com/'
    mail(to: @user.email, subject: 'Your order has shipped!')
  end
end
