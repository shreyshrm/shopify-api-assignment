# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


private_shop = PrivateShop.create!(
  shopify_domain: 'grocerbox-demo.myshopify.com',
  api_key: '4679a6b19a9b7896cf03cf5501c661ef',
  password: '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'
)

private_shop.with_shopify_session