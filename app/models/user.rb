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
    get_cart_items.each { |item| total_price+= (item.price * get_quantity(item.id)) }
    sprintf("%.2f", total_price)
  end

  def get_cart_items
    cart_ids = $redis.lrange "cart#{id}", 0, 100
    Item.find(cart_ids)
  end

  def get_quantity(item)
    ids = $redis.lrange "cart#{id}", 0, 100 # => ["2", "1"]
    ids.each do |id|
      if id.to_i == item
        return ids.count(id)
      end
    end
  end

end
