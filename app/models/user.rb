class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :purchases, foreign_key: :buyer_id
  has_many :items, through: :purchases

  validates :state, length: { maximum: 2 }

  before_save :uppercase_state
  
  def uppercase_state
    state.upcase!
  end

  def cart_count
    $redis.llen "cart#{id}"
  end

  def cart_total_price
    total_price = 0
    get_cart_items.each { |item| total_price+= (item.price * get_quantity(item.id)) }
    sprintf("%.2f", total_price)
  end

  def add_sales_tax
    tax = cart_total_price.to_f * (7.25 / 100)
    total_price = tax + cart_total_price.to_f
    return sprintf("%.2f", total_price)
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

  def purchase_cart_items!
    get_cart_items.each { |item| purchase?(item) }
    $redis.del "cart#{id}"
  end

  def purchase(item)
    items << item unless purchase?(item)
  end

  def purchase?(item)
    items.include?(item)
  end


end
