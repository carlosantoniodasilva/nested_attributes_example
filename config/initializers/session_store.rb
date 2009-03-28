# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_test_nested_attributes_session',
  :secret      => 'fa71f1d230b7e16d2c37d06f8f9787711b1a7f1d10e0d44b3deed179d80122ad7d376e4daaa1981fcfbfdeb1e62151e38fd15b53fb9104bb0e81ce505db8f0f1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
