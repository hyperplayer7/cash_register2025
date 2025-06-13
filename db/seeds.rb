# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Product.create!(name: "Green Tea", price: 3.11, code: "GR1")
Product.create!(name: "Strawberry", price: 5.00, code: "SR1")
Product.create!(name: "Coffee", price: 11.23, code: "CF1")
