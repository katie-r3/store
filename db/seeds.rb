# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.delete_all

item_list = [
  ["phonecase", 12.99, "galaxy s8 phone case", 10],
  ["phone charger", 12.99, "charger for iphone 7", 10],
  ["water bottle", 12.99, "steel water bottle", 10],
  ["mouse", 12.99, "mouse for mac", 10, "MLA02.jpeg"],
  ["backpack", 12.99, "backpack with room for laptop", 10],
  ["galaxy s8", 399.99, "s8 galaxy phone", 10],
  ["iphone 7", 359.99, "iphone 7", 10],
  ["mousepad", 12.99, "silly kitty mousepad", 10],
  ["kombucha", 12.99, "variety pack of synergy kombucha", 10],
  ["mouse", 9.99, "cheap mouse", 10],
  ["stuff", 4.49, "lots of stuff", 10],
  ["snacks", 9.99, "variety of snacks", 10],
  ["phone charger", 14.99, "charger for galaxy s8", 10]
]

item_list.each do |name, price, description, quantity|
  Item.create(name: name, price: price, description: description, quantity: quantity)
end
