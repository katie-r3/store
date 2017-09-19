# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.delete_all

item_list = [
  ["phonecase", 12.99],
  ["phone charger", 12.99],
  ["water bottle", 12.99],
  ["mouse", 12.99],
  ["backpack", 12.99],
  ["galaxy s4", 399.99],
  ["iphone 7", 359.99],
  ["mousepad", 12.99],
  ["kombucha", 12.99]
]

item_list.each do |name, price|
  Item.create(name: name, price: price)
end
