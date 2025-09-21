class LandingsController < ApplicationController
  allow_unauthenticated_access
  layout "landing"
  def index
    redirect_to expenses_path if authenticated?
  end

  def privacy
  end

  def terms
  end
end
