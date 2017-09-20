class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :purchases, foreign_key: :buyer_id
  has_many :items

  def cart_count
    $redis.llen "cart#{id}"
  end

  def cart_total_price
    total_price = 0
    get_cart_items.each { |item| total_price+= item.price }
    sprintf("%.2f", total_price)
  end

  def get_cart_items
    cart_ids = $redis.lrange "cart#{id}", -100, 100
    Item.find(cart_ids)
  end

  def get_quantity(item)
    ids = $redis.lrange "cart#{id}", -100, 100 # => ["2", "1"]
    ids.each do |i|
      if item.id == i
        return ids.count(item)
      end
    end
  end


end
