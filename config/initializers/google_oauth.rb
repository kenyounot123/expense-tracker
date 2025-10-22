Rails.application.config.google_oauth = {
  client_id: Rails.application.credentials.dig(:google_oauth, :client_id),
  client_secret: Rails.application.credentials.dig(:google_oauth, :client_secret),
  authorization_uri: "https://accounts.google.com/o/oauth2/auth"
}
