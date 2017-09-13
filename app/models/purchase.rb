class Purchase < ApplicationRecord

  belongs_to :item
  belongs_to :buyer, class_name: 'User'

  def purchase_cart_items!
    get_cart_items.each { |item| purchase(item) }
    $redis.del "cart#{id}"
  end

  def purchase(item)
    items << item unless purchase? (item)
  end

  def purchase?(item?)
    items.include?(item)
  end
  
end
