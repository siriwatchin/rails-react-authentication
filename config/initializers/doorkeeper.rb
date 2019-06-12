Doorkeeper.configure do
  orm :active_record

  resource_owner_authenticator do
    raise "Please configure doorkeeper resource_owner_authenticator block located in #{__FILE__}"
  end

  resource_owner_from_credentials do |_routes|
    user = User.find_for_database_authentication(email: params[:email])
    user if user&.valid_password?(params[:password])
  end

  access_token_expires_in 2.hours

  use_refresh_token

  default_scopes  :public
  optional_scopes :write, :update

  grant_flows %w[password]

  skip_authorization do
    true
  end
end
