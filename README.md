# Shopify API Assignment

The goal of this assignment is to setup a Rails app, connect it to a Shopify store and upload some products to it.

The following instructions will show you how to setup your rails app, install necessary gems and create PrivateShop and Delivery models to interact with our Shopify store.

You will also get be given staff access to a Shopify store that we'll use to create orders and test our app.

## Setup

Create a Rails and React app by using [thoughtbot's suspenders gem](https://github.com/thoughtbot/suspenders) which will give you instructions on installing prerequisites and setting up your development environment.

Then install the following gems that we'll use to further setup our app:
  [attr_encrypted](https://github.com/attr-encrypted/attr_encrypted)
  [shopify_app](https://github.com/Shopify/shopify_app)

Use the ShopifyApp generator by running `rails generate shopify_app` on the command line to generate the files and database migrations needed to connect to Shopify.

## Create Models

Create Private Shop model with the command `rails generate model PrivateShop`. Use [ActiveRecord Migrations docs](https://guides.rubyonrails.org/active_record_migrations.html) for reference.

Contents of PrivateShop:

```ruby
create_table :private_shops do |t|
  t.string :shopify_domain, index: true
  t.string :encrypted_api_key
  t.string :encrypted_api_key_iv, index: true, unique: true
  t.string :encrypted_password
  t.string :encrypted_password_iv, index: true, unique: true
  t.string :encrypted_shared_secret
  t.string :encrypted_shared_secret_iv, index: true, unique: true

  t.timestamps
end
```

The model:

```ruby
class PrivateShop
  attr_encrypted :api_key, key: :encryption_key
  attr_encrypted :password, key: :encryption_key
  attr_encrypted :shared_secret, key: :encryption_key

  def with_shopify_session
    ShopifyAPI::Base.site = "https://#{api_key}:#{password}@#{shopify_domain}"
    ShopifyAPI::Base.api_version = ShopifyApp.configuration.api_version
    result = yield
    ShopifyAPI::Base.clear_session

    result
  end
end
```

Now you can use `rails db:migrate` to create our tables.


## The Assignment Itself

Using the [ShopifyAPI](https://github.com/Shopify/shopify_api) which is installed automatically with the shopify_app gem, and the documentation found at [Shopify REST API](https://shopify.dev/docs/admin-api/rest/reference) we want to:

- Register our demo shop using the PrivateShop model with using the private app credentials [found here](https://grocerbox-demo.myshopify.com/admin/apps/private/261167513768)

```ruby
PrivateShop.create!(
  shopify_domain: 'grocerbox-demo.myshopify.com',
  api_key: '[PRIVATE APP API KEY]',
  password: '[PRIVATE APP PASSWORD]'
)
```

- From your console, using the `PrivateShop.with_shopify_session` and `ShopifyAPI::Products.create(...)` methods, populate the shop with the following products:

```
[
  {
    title: "Onions",
    body_html: "<p>A beautiful onion.</p>",
    product_type: "Grocery",
    tags: ["Produce"],
    variants: [{taxable: false, option1: "lb", price: "$0.75"}]
  },
  {
    title: "Avocados",
    body_html: "<p>Perfect for guacamole or salad.</p>",
    product_type: "Grocery",
    tags: ["Produce"],
    variants: [{taxable: false, option1: "unit", price: "$1.99"}]
  }
]
```

## Submission

Fork this repository, clone it and build your rails app here. Create a pull request when its ready for review.
