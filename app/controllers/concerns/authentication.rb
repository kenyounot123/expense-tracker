module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :authenticated?
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private
    def authenticated?
      resume_session
    end

    def require_authentication
      resume_session || request_authentication
    end

    def resume_session
      Current.session ||= (find_session_by_cookie || find_session_by_remember_token)
    end

    def find_session_by_cookie
      Session.find_by(id: cookies.signed[:session_id]) if cookies.signed[:session_id]
    end

    def find_session_by_remember_token
      if cookies.signed[:remember_token] && (session = Session.find_by(remember_token: cookies.signed[:remember_token]))
        cookies.signed[:session_id] = { value: session.id, httponly: true, same_site: :lax }
        session
      end
    end

    def request_authentication
      session[:return_to_after_authenticating] = request.url
      redirect_to login_path
    end

    def after_authentication_url
      session.delete(:return_to_after_authenticating) || expenses_url
    end

    def start_new_session_for(user)
      user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
        Current.session = session
        cookies.signed[:session_id] = { value: session.id, httponly: true, same_site: :lax }

        if params[:remember_me] == "1"
          cookies.signed.permanent[:remember_token] = {
            value: session.remember_token,
            httponly: true,
            same_site: :lax,
            expires: 2.weeks.from_now
          }
        end
      end
    end

    def terminate_session
      Current.session.destroy
      cookies.delete(:session_id)
      cookies.delete(:remember_token)
    end
end
