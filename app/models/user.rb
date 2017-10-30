class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :purchases, foreign_key: :user_id
  has_many :items, through: :purchases
  has_many :reviews

  validates :state, length: { maximum: 2 }, presence: true
  validates :email, :first_name, :last_name, :address_line1, :city, length: { minimum: 2 }, presence: true
  validates_length_of :zipcode, :is => 5
  validates :zipcode, presence: true

  # validate :address_verification

  before_save :uppercase_state
  before_save :uppercase_name
  before_save :uppercase_city


  def uppercase_state
    if Current.user
      Current.user.state.upcase!
    end
  end

  def uppercase_name
    if Current.user
      Current.user.first_name.capitalize!
      Current.user.last_name.capitalize!
    end
  end

  def uppercase_city
    if Current.user
      Current.user.city.capitalize!
    end
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def full_address
    [city, state, zipcode].compact.join(', ')
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
    get_cart_items.each do |item|
      purchase?(item)
      cart_quantity = get_quantity(item.id)
      item.quantity -= cart_quantity
      item.save!
    end
    $redis.del "cart#{id}"
  end

  def no_more?
    get_cart_items.each do |item|
      return false if get_quantity(item.id) == item.quantity
    end
  end

  def purchase(item)
    items << item unless purchase?(item)
  end

  def purchase?(item)
    items.include?(item)
  end

#   private
#
#   def address_verification
#   lob = Lob::Client.new(api_key: "test_8bf028b29ac1c2c97ce7e85d57d96d51feb")
#
#   address = lob.us_verifications.verify(
#     primary_line: self.address_line1,
#     secondary_line: self.address_line2,
#     city: self.city,
#     state: self.state,
#     zip_code: self.zipcode,
#   )
#
#   if address["deliverability"] != "deliverable"
#     errors.add("This address is not deliverable: ", address["deliverability"])
#   end
#
# end


end
