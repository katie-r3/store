# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.delete_all

item_list = [
  ["phonecase", 12.99, "galaxy s8 phone case", 10, "galaxy-s8-plus-cases-poetic-revolution-840x473.jpg"],
  ["phone charger", 12.99, "charger for iphone 7", 10, "41IpHPsDElL._SX425_.jpg"],
  ["water bottle", 12.99, "steel water bottle", 10, "bbbyo-stainless-1litre-silver.jpg"],
  ["mouse", 12.99, "mouse for mac", 10, "MLA02.jpeg"],
  ["backpack", 12.99, "backpack with room for laptop", 10, "CTP160_03_CommuterLaptopBackpack-black.jpg"],
  ["galaxy s8", 399.99, "s8 galaxy phone", 10, "galaxy-s8_gallery_right_side_coralblue_s4.png"],
  ["iphone 7", 359.99, "iphone 7", 10, "apple-iphone-7-red-gallery-img-1.jpg"],
  ["mousepad", 12.99, "silly kitty mousepad", 10, "galaxy_cat_screaming_in_space_mouse_pad-r430a38016..."],
  ["kombucha", 12.99, "variety pack of synergy kombucha", 10, ],
  ["mouse", 9.99, "cheap mouse", 10, "0001597_wireless-optical-laptop-mouse.jpeg"],
  ["stuff", 4.49, "lots of stuff", 10],
  ["snacks", 9.99, "variety of snacks", 10]
]

item_list.each do |name, price, description, quantity, avatar_file_name|
  Item.create(name: name, price: price, description: description, quantity: quantity, avatar_file_name: avatar_file_name)
end
