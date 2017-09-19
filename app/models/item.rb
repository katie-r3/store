class Item < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "no-image-icon-15.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  has_many :purchases
  has_many :buyers, through: :purchases
  has_many :comments

  def cart_action(current_user)
    if current_user
      "Add to"
    else
      "Add another to"
    end
  end


  def self.search(search)
    where("name LIKE ? OR description LIKE ?", "%#{search}", "%#{search}")
  end


end
