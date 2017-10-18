class InventoryMailer < ApplicationMailer
  default from: 'thestore909090@gmail.com'

  def inventory_email(item)
    @item = item.name
    @url = 'http://intense-spire-74031.herokuapp.com'
    mail(to: 'thestore909090@gmail.com', subject: 'OUT OF STOCK - ORDER SOON')
  end
end
