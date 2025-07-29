class AdminController < ActionController::Base
  before_action :authenticate_admin

  private
    def authenticate_admin
      return if Rails.env.local?

      authenticate_or_request_with_http_basic do |username, password|
        username == Rails.application.credentials.dig(:admin, :username) && \
        password == Rails.application.credentials.dig(:admin, :password)
      end
    end
end
