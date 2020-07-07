class CreatePrivateShops < ActiveRecord::Migration[6.0]
  def change
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
  end
end
