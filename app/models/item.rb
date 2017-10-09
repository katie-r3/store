class Item < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "no-image-icon-15.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_and_belongs_to_many :purchases
  has_many :users, through: :purchases
  has_many :reviews

  extend FriendlyId
  friendly_id :name, use: :slugged


  def cart_action(current_user)
    if current_user
      "Add to"
    end
  end


  def self.search(search)
    where("name LIKE ? OR description LIKE ?", "%#{search}", "%#{search}")
  end


end
