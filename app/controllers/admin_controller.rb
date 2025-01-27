class AdminController < ActionController::Base
  http_basic_authenticate_with name: Rails.application.credentials.admin.username,
                             password: Rails.application.credentials.admin.password
end
