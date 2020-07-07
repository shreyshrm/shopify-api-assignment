class PrivateShop < ApplicationRecord
    attr_encrypted :api_key, key: ENV['encryption_key'].bytes[0..31].pack( "c" * 32 )
    attr_encrypted :password, key: ENV['encryption_key'].bytes[0..31].pack( "c" * 32 )
    attr_encrypted :shared_secret, key: ENV['encryption_key'].bytes[0..31].pack( "c" * 32 )

  def with_shopify_session
    ShopifyAPI::Base.site = "https://#{api_key}:#{password}@#{shopify_domain}"
    ShopifyAPI::Base.api_version = ShopifyApp.configuration.api_version
    # result = yield
    # ShopifyAPI::Base.clear_session

    # result
  end
end
