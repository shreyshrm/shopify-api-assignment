# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ENV['encryption_key'] = SecureRandom.random_bytes(32)