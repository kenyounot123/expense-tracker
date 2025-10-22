class Auth::GoogleOauthController < ApplicationController
  allow_unauthenticated_access

  def authorize
    # Create Google OAuth2 client
    client = Signet::OAuth2::Client.new(
      client_id: google_oauth_config[:client_id],
      client_secret: google_oauth_config[:client_secret],
      authorization_uri: google_oauth_config[:authorization_uri],
      redirect_uri: auth_google_oauth_callback_url,
      scope: "openid email profile"
    )

    # Generate the authorization URL and redirect
    redirect_to client.authorization_uri.to_s, allow_other_host: true
  end

  def callback
    # Exchange authorization code for tokens
    client = Signet::OAuth2::Client.new(
      client_id: google_oauth_config[:client_id],
      client_secret: google_oauth_config[:client_secret],
      token_credential_uri: "https://oauth2.googleapis.com/token",
      redirect_uri: auth_google_oauth_callback_url,
      code: params[:code]
    )

    # Fetch the access token
    client.fetch_access_token!

    # Get user info from Google
    user_info = fetch_user_info(client.access_token)

    # Find or create user from OAuth data
    user = User.find_or_create_from_oauth(
      "google",
      user_info["sub"],
      user_info["email"],
      {
        access_token: client.access_token,
        refresh_token: client.refresh_token,
        expires_at: client.expires_at
      }
    )

    # Sign the user in
    start_new_session_for user
    redirect_to after_authentication_url, notice: "Successfully signed in with Google!"
  rescue => e
    Rails.logger.error "OAuth callback error: #{e.message}"
    redirect_to login_path, alert: "Authentication failed. Please try again."
  end

  private
    def google_oauth_config
      Rails.application.config.google_oauth
    end

    def fetch_user_info(access_token)
      conn = Faraday.new(url: "https://www.googleapis.com") do |f|
        f.adapter Faraday.default_adapter
      end

      response = conn.get("/oauth2/v3/userinfo") do |req|
        req.headers["Authorization"] = "Bearer #{access_token}"
      end

      JSON.parse(response.body)
    end
end
