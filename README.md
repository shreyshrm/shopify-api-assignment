# Shopify API Assignment

The goal of this assignment is to setup a Rails app, connect it to a Shopify store and setup a webhook that creates a fake delivery when a Shopify order is made.

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

Create Delivery Model with `rails generate model Delivery`.

```ruby
create_table :deliveries do |t|
  t.string :shopify_domain, index: true
  t.bigint :shopify_order_id, index: true
  t.jsonb :order
  t.timestamps
end
```

And class:

```ruby
class Delivery
  belongs_to :shop, class_name: 'PrivateShop', foreign_key: :shopify_domain, primary_key: :shopify_domain
end
```

Now you can use `rails db:migrate` to create our tables.


## The Assignment Itself

Using the [ShopifyAPI](https://github.com/Shopify/shopify_api) which is installed automatically with the shopify_app gem, and the documentation found at [Shopify REST API](https://shopify.dev/docs/admin-api/rest/reference) we want to:

- Install a webhook for `orders/create` that loads the order with `ShopifyAPI::Orders.find(params[:id])` and saves it to the database in the delivery model with:

```ruby
Delivery.create!(
  shopify_domain: '[SHOPIFY_DOMAIN]',
  shopify_order_id: '[ID]',
  order: order # The shopify order that you fetched from the ShopifyAPI
)
```

## Submission

Fork this repository, clone it and build your rails app here. Create a pull request when its ready for review.
