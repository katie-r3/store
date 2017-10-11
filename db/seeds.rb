# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.delete_all

item_list = [
  ["phonecase", 12.99, "Galaxy S8 phonecase", 10],
  ["phone charger", 12.99, "Charger for iPhone 7", 10],
  ["water bottle", 12.99, "Steel water bottle", 10],
  ["mouse", 12.99, "Wireless Mac mouse", 10, "MLA02.jpeg"],
  ["backpack", 12.99, "Backpack with flap for laptop", 10],
  ["Galaxy S8", 399.99, "S8 Galaxy phone", 10],
  ["iPhone 7", 359.99, "iPhone 7", 10],
  ["mousepad", 12.99, "Silly kitty mousepad", 10],
  ["kombucha", 12.99, "Variety pack of Synergy kombucha", 10],
  ["mouse", 9.99, "Wireless mouse, compatible with any computer", 10],
  ["water bottle", 4.49, "Glass water bottle(colors may vary)", 10],
  ["snack pack", 9.99, "Snack Pack - not guaranteed fresh", 10],
  ["phone charger", 14.99, "Charger for Galaxy S8", 10]
]

item_list.each do |name, price, description, quantity|
  Item.create(name: name, price: price, description: description, quantity: quantity)
end
