# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call

CreateManufacturersService.new.call
Manufacturer.all.each { |m| puts 'CREATED MANUFACTURER: ' << m.name }

CreateMerchantsService.new.call
Merchant.all.each { |m| puts 'CREATED MERCHANT: ' << m.name }

CreateProductService.new.call
Product.all.each { |p| puts 'CREATED PRODUCT: ' << p.name }

puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.
