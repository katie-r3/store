class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :purchases, foreign_key: :buyer_id
  has_many :items ,through: :purchases

  def cart_count
    $redis.scard "cart#{id}"
  end

  def cart_total_price
    total_price = 0
    get_cart_items.each { |item| total_price+= item.price }
    total_price
  end

  def get_cart_items
    card_ids = $redis.smembers "cart#{id}"
    Item.find(cart_ids)
  end

end
