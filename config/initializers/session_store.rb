# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_calmat_session',
  :secret      => 'c56a8aa35a74a9a2996c69955794bdd8e65e936ac35c318199c936883f28345357f28c15a649f7397af3f2b21755ff0336e4165ef09a8819ab064193fa7b3083'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
