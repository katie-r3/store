# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.delete_all

item_list = [
  ["phonecase", 12.99, "galaxy s8 phone case"],
  ["phone charger", 12.99, "charger for iphone 7"],
  ["water bottle", 12.99, "steel water bottle"],
  ["mouse", 12.99, "mouse for mac"],
  ["backpack", 12.99, "backpack with room for laptop"],
  ["galaxy s4", 399.99, "s4 galaxy phone"],
  ["iphone 7", 359.99, "iphone 7"],
  ["mousepad", 12.99, "silly kitty mousepad"],
  ["kombucha", 12.99, "variety pack of synergy kombucha"]
]

item_list.each do |name, price, description|
  Item.create(name: name, price: price, description: description)
end
