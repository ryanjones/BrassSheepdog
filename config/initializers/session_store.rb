# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_BrassSheepdog_session',
  :secret      => 'be0b8c8ca2d379f0b0593fefd2d647262474a361cfb542c4f2fb52027b49091accd5c28ae53f241232d345a0eb5d34abbedcab38f074ccf8566328a2da638b90'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
